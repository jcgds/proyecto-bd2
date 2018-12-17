ALTER SESSION SET CURRENT_SCHEMA=WINE_SCHEMA;

create or replace procedure insertar_concurso(pid number DEFAULT ids_seq.nextval, nombre varchar2, dc datosDeContacto, tipoCata varchar2, deCatadores char, caracteristicas varchar2) as
begin
    INSERT INTO Concurso VALUES (
      pid,
      nombre,
      dc,
      tipoCata,
      deCatadores,
      premio_nt(),
      escala_nt(),
      caracteristicas
    );
    DBMS_OUTPUT.PUT_LINE('------------------------------------------------');
    DBMS_OUTPUT.PUT_LINE('Concurso insertado (id = ' || to_char(pid) || ')');
    DBMS_OUTPUT.PUT_LINE('------------------------------------------------');
end;
/
create or replace function produccion_bodega_en (idBodega IN number, anioDeseado IN number)
return number is
    produccion number := 0;
BEGIN
       select t.valor into produccion
        from the (
            select produccionAnual
            from Bodega
            where id = idBodega
        ) t
        where t.anio = anioDeseado;
    return produccion;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        return 0;
END;
/

create or replace function exportacion_bodega_en (idBodega IN number, anioDeseado IN number)
return number is
    exportacion number := 0;
BEGIN
       select sum(t.tipovalor.valor) into exportacion
        from the (
            select exportacionAnual
            from Bodega
            where id = idBodega
        ) t
        where t.tipovalor.anio = anioDeseado;
    return exportacion;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        return 0;
END;
/

create or replace function consumo_int_bodega_en (idBodega IN number, anioDeseado IN number)
return number is
BEGIN
       return produccion_bodega_en(idBodega, anioDeseado) - exportacion_bodega_en(idBodega, anioDeseado);
END;
/


create or replace function produccion_pais_en (idPais IN number, anioDeseado IN number)
return number is
    produccion number := 0;
BEGIN

    select t.valor into produccion
        from the (
            select produccionAnual
            from Pais
            where pais.id = idPais
        ) t
        where t.anio = anioDeseado;
    return produccion;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        return 0;
END;
/
create or replace function produccion_marca_en (idMarca IN number, anioDeseado IN number)
return number is
    produccion number := 0;
BEGIN

    select t.valor into produccion
        from the (
            select produccionAnual
            from MarcaVino
            where id = idMarca
        ) t
        where t.anio = anioDeseado;

        return produccion;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        return 0;
END;

/
/*
    Consigue el a�o m�s peque�o (m�s viejo) revisando todos los registros
    de produccion anual de las marcas de vino.
*/
create or replace function conseguir_anio_minimo
return number is
    anio number;
    loopYear number;
    minYear number := NULL;
begin
    << marca_loop >>
    for marca in (select id from MarcaVino)
    loop
        select min(anio) into loopYear
        from the (select produccionAnual from MarcaVino where id = marca.id);

        if (minYear is null or loopYear < minYear) then
            minYear := loopYear;
        end if;
    end loop marca_loop;

    return minYear;
end;
/

create or replace function exportacion_marca_en (idMarca IN number, anioDeseado IN number)
return number is
    exportacion number := 0;
BEGIN

    select SUM(t.tipovalor.valor) into exportacion
    from the (select z.exportacionAnual from MarcaVino z where z.id = idMarca) t
    where t.tipovalor.anio = anioDeseado;

    return exportacion;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        return 0;
END;
/
/*
    Este procedimiento se encarga de calcular y actualizar los valores de produccion
    de todas las bodegas segun la produccion de sus marcas de vino.

    Al ser ejecutado elimina todos los registros de las NT produccionAnual de las bodegas
    y los reemplaza calculando de nuevo la produccion segun las marcas de
    vino entre el a�o minimo y maximo.
*/
create or replace procedure CalcularProduccionTotalBodegas as
anio_min number := conseguir_anio_minimo();
anio_max number;
acumulador1 number := 0;
begin
    select to_char(sysdate, 'YYYY') into anio_max from dual;
    << bodegas_loop >>
    for bodega in (select id, nombre from Bodega)
    loop
        DBMS_OUTPUT.PUT_LINE('Bodega ' || bodega.nombre || ' | ' || to_char(bodega.id));
        DELETE FROM THE (select vv.produccionAnual from Bodega vv where vv.id = bodega.id);

        -- Recorremos los a�os y vamos sumando la produccion de las marcas de vino de la bodega en ese a�o
        << year_loop >>
        for i in anio_min .. anio_max loop
            acumulador1 := 0;
            -- Este query consigue todas las marcas de vino de la Bodega actual en el loop
            << marcas_loop >>
            for marca in (
                    select distinct mv.id, mv.nombre
                    from MarcaVino_B_DO mvbdo, MarcaVino mv
                    where mvbdo.fk_bodega = bodega.id
                        and mvbdo.fk_marcavino = mv.id
                        and mvbdo.fk_clasificacionvinos = mv.fk_clasificacionvinos)
            loop
                DBMS_OUTPUT.PUT_LINE('Marca ' || marca.nombre);
                -- Vamos sumando la produccion de las marcas en el acumulador de la bodega
                acumulador1 := acumulador1 + produccion_marca_en(marca.id, i);
            end loop marcas_loop;

            DBMS_OUTPUT.PUT_LINE('Produccion anio ' || TO_CHAR(i) || ' es: ' || to_char(acumulador1));

            -- Guardar en produccionAnual de la Bodega este valor
            INSERT INTO THE (select vv.produccionAnual from Bodega vv where vv.id = bodega.id)
            values (tipo_valor(i, acumulador1, 'litros'));

        end loop year_loop;
    end loop bodegas_loop;
end;
/

/*
    Este procedimiento se encarga de calcular y actualizar los valores de exportacion
    de todas las bodegas segun la produccion de sus marcas de vino.

    Al ser ejecutado elimina todos los registros de las NT exportacionAnual de las bodegas
    y los reemplaza calculando de nuevo la exportacion segun las marcas de
    vino y pais entre el a�o minimo y maximo.
*/
create or replace procedure CalcExportacionTotalBodegas as
anio_min number := conseguir_anio_minimo();
anio_max number;
type pais_exportacion is table of number index by varchar2(50);
distribucionExp pais_exportacion;
paisIndex varchar2(50);
begin
    select to_char(sysdate, 'YYYY') into anio_max from dual;
    << bodegas_loop >>
    for bodega in (select id, nombre from Bodega)
    loop
        DBMS_OUTPUT.PUT_LINE('Bodega ' || bodega.nombre || ' | ' || to_char(bodega.id));
        DELETE FROM THE (select vv.exportacionAnual from Bodega vv where vv.id = bodega.id);

        -- Recorremos los a�os y vamos sumando la produccion de las marcas de vino de la bodega en ese a�o
        << year_loop >>
        for i in anio_min .. anio_max loop
            distribucionExp.Delete();
            -- Este query consigue todas las marcas de vino de la Bodega actual en el loop
            << marcas_loop >>
            for marca in (
                    select distinct mv.id, mv.nombre
                    from MarcaVino_B_DO mvbdo, MarcaVino mv
                    where mvbdo.fk_bodega = bodega.id
                        and mvbdo.fk_marcavino = mv.id
                        and mvbdo.fk_clasificacionvinos = mv.fk_clasificacionvinos)
            loop
                DBMS_OUTPUT.PUT_LINE('Marca ' || marca.nombre);

                -- Este query consigue el valor y pais de las exportaciones de la marca de vino actual
                -- en el a�o del loop
                << distribucion_loop >>
                for dist in (select nt.tipovalor.valor valor, nt.pais pais from the
                            (select mv.exportacionAnual from MarcaVino mv
                            where mv.id = marca.id) nt
                            where nt.tipovalor.anio = i)
                loop
                    --DBMS_OUTPUT.PUT_LINE('Pais: ' || dist.pais || ' Valor: ' || to_char(dist.valor) || ' Anio: ' || to_char(i));
                    -- Capturamos la excepcion NO_DATA_FOUND pues si en el hashmap no existe el valor esta se dispara
                    begin
                         distribucionExp(dist.pais) := distribucionExp(dist.pais) + dist.valor;
                    exception
                        when NO_DATA_FOUND then
                            distribucionExp(dist.pais) := dist.valor;
                    end;
                end loop distribucion_loop;

            end loop marcas_loop;

            -- Recorremos los valores en el hashmap y vamos guardando en la exportacionAnual de la bodega
            paisIndex := distribucionExp.first;
            << assoc_array_loop >>
            while (paisIndex is not null) loop
                DBMS_OUTPUT.PUT_LINE('Anio: ' || to_char(i) || ' Pais: ' || paisIndex || ' Valor: ' || to_char(distribucionExp(paisIndex)));

                INSERT INTO THE (select vv.exportacionAnual from Bodega vv where vv.id = bodega.id)
                values (distribucion_exp(tipo_valor(i, distribucionExp(paisIndex), 'litros'), paisIndex));

                paisIndex := distribucionExp.next(paisIndex);
            end loop assoc_array_loop;

        end loop year_loop;
    end loop bodegas_loop;
end;
/

/*
    Calcula y actualiza los valores de produccion anual de todos los paises,
    actualizando primero los valores de produccion de las bodegas mediante el
    metodo CalcularProduccionTotalBodegas().
*/
create or replace procedure CalcularProduccionTotal as
anio_min number := conseguir_anio_minimo();
anio_max number;
acumulador number := 0;
begin
    select to_char(sysdate, 'YYYY') into anio_max from dual;

    CalcularProduccionTotalBodegas();
    -- Se termino el procedimiento anterior asi que la produccionAnual de las Bodegas deberian estar actualizadas.

    << pais_loop >>
    for PAIS in (select p.id, p.nombre from Pais p)
    loop
        DELETE FROM THE (select vv.produccionAnual from Pais vv where vv.id = PAIS.id);

        << year_loop >>
        for ANIO in anio_min .. anio_max loop
            acumulador := 0;

            << bodega_loop >>
            for BODEGA in (
                select distinct bo.id, bo.nombre
                from Bodega bo, Region rg, DenominacionDeOrigen do, B_DO bdo
                where rg.fk_pais = PAIS.id
                and bdo.fk_do_region = rg.id
                and bo.id = bdo.fk_bodega)
            loop
                acumulador := acumulador + produccion_bodega_en(BODEGA.id, ANIO);
            end loop bodega_loop;

            DBMS_OUTPUT.PUT_LINE( PAIS.nombre || ' en ' || TO_CHAR(anio) || ' produjo: ' || to_char(acumulador));

            INSERT INTO THE (select vv.produccionAnual from Pais vv where vv.id = PAIS.id)
            values (tipo_valor(anio, acumulador, 'litros'));

        end loop year_loop;

    end loop pais_loop;

end;
/

create or replace procedure CalcularExportacionTotal as
anio_min number := conseguir_anio_minimo();
anio_max number;
type pais_exportacion is table of number index by varchar2(50);
distribucionExp pais_exportacion;
paisIndex varchar2(50);
begin
    select to_char(sysdate, 'YYYY') into anio_max from dual;
    CalcExportacionTotalBodegas();

    << pais_loop >>
    for PAIS in (select p.id, p.nombre from Pais p)
    loop
        DELETE FROM THE (select vv.exportacionAnual from Pais vv where vv.id = PAIS.id);

         << year_loop >>
        for ANIO in anio_min .. anio_max loop
            distribucionExp.Delete();

            << bodega_loop >>
            for BODEGA in (
                select distinct bo.id, bo.nombre
                from Bodega bo, Region rg, DenominacionDeOrigen do, B_DO bdo
                where rg.fk_pais = PAIS.id
                and bdo.fk_do_region = rg.id
                and bo.id = bdo.fk_bodega)
            loop

                << distribucion_loop >>
                for dist in (select nt.tipovalor.valor valor, nt.pais pais from the
                            (select bo.exportacionAnual from Bodega bo
                            where bo.id = BODEGA.id) nt
                            where nt.tipovalor.anio = ANIO)
                loop
                    begin
                         distribucionExp(dist.pais) := distribucionExp(dist.pais) + dist.valor;
                    exception
                        when NO_DATA_FOUND then
                            distribucionExp(dist.pais) := dist.valor;
                    end;
                end loop distribucion_loop;

            end loop bodega_loop;

            paisIndex := distribucionExp.first;
            << assoc_array_loop >>
            while (paisIndex is not null) loop
                DBMS_OUTPUT.PUT_LINE('Anio: ' || to_char(ANIO) || ' Pais: ' || paisIndex || ' Valor: ' || to_char(distribucionExp(paisIndex)));

                INSERT INTO THE (select vv.exportacionAnual from Pais vv where vv.id = PAIS.id)
                values (distribucion_exp(tipo_valor(ANIO, distribucionExp(paisIndex), 'litros'), paisIndex));

                paisIndex := distribucionExp.next(paisIndex);
            end loop assoc_array_loop;

        end loop year_loop;

    end loop pais_loop;
end;
/

/* Lo devuelve en litros */
create or replace function CalcularProduccionPais(p_idPais number, p_anio number) 
return number is
produccionEnElAnio number := 0;
nombrePais varchar2(50);
begin
    select nombre into nombrePais
    from Pais where id = p_idPais;

    select t.valor into produccionEnElAnio
    from the (select produccionAnual from Pais where id = p_idPais) t
    where t.anio = p_anio;

    return produccionEnElAnio;
end;
/

/* Lo devuelve en litros */
create or replace function CalcularExportacionPais(p_idPais number, p_anio number) 
return number is
exportacionEnElAnio number := 0;
nombrePais varchar2(50);
begin
    select nombre into nombrePais
    from Pais where id = p_idPais;

    select SUM(t.tipovalor.valor) into exportacionEnElAnio
    from the (select exportacionAnual from Pais where id = p_idPais) t
    where t.tipovalor.anio = p_anio;

    return exportacionEnElAnio;
end;
/


/* Lo devuelve en litros */
create or replace function CalcularConsumoInterno(p_idPais number, p_anio number) 
return number is
produccionEnElAnio number := 0;
exportacionEnElAnio number := 0;
nombrePais varchar2(50);
begin
    select nombre into nombrePais
    from Pais where id = p_idPais;

    select t.valor into produccionEnElAnio
    from the (select produccionAnual from Pais where id = p_idPais) t
    where t.anio = p_anio;

    select SUM(t.tipovalor.valor) into exportacionEnElAnio
    from the (select exportacionAnual from Pais where id = p_idPais) t
    where t.tipovalor.anio = p_anio;

    DBMS_OUTPUT.PUT_LINE('-- ' || nombrePais || ' -------------------------------');
    DBMS_OUTPUT.PUT_LINE('Produccion en ' || to_char(p_anio) || ': ' || to_char(produccionEnElAnio));
    DBMS_OUTPUT.PUT_LINE('Exportacion en ' || to_char(p_anio) || ': ' || to_char(exportacionEnElAnio));
    DBMS_OUTPUT.PUT_LINE('Consumo interno en ' || to_char(p_anio) || ': ' || to_char(produccionEnElAnio - exportacionEnElAnio));
    DBMS_OUTPUT.PUT_LINE('------------------------------------------------');

    return produccionEnElAnio - exportacionEnElAnio;
end;
/

create or replace function formatear_ccmadera(idMarca number)
return varchar2 is
    holder varchar2(2);
begin
    select contactoConMadera into holder
    from MarcaVino
    where id = idMarca;

    if holder like 'S' then
        return 'S�';
    else
        return 'No';
    end if;
end;
/

create or replace function formatear_maridajes(idMarca number)
return varchar2 is
    holder varchar2(1000) := null;
    mar maridajes;
    total number;
begin
    select maridaje into mar
    from MarcaVino
    where id = idMarca;

    total := mar.count;
    for i in 1 .. total loop
        if holder is null then
            holder := mar(i) || ', ';
        elsif (i != total) then
            holder := holder || mar(i) || ', ';
        else
            holder := holder || mar(i);
        end if;
    end loop;

    return holder;
end;
/

create or replace procedure insertar_premio_a(idConcurso number, nombre varchar2, p_posicion number, descripcion varchar2, tipo varchar2, premioMoneda number)
as
    premiosDePosExistentes number := 0;
begin

    if premioMoneda < 0 then
        RAISE_APPLICATION_ERROR(-20100, 'El valor monetario del premio no puede ser negativo');
    end if;

    if p_posicion < 1 then
        RAISE_APPLICATION_ERROR(-20101, 'La posicion del premio no puede ser menor a 1');
    end if;

    select count(*) into premiosDePosExistentes
    from the (select premios from concurso where id = idConcurso) nt
    where nt.posicion = p_posicion;

    if premiosDePosExistentes > 0 then
        RAISE_APPLICATION_ERROR(-20102, 'Ya existe un premio para esta posicion');
    end if;

    INSERT INTO THE (SELECT premios from Concurso where id = idConcurso) VALUES
    (premio(nombre, p_posicion, descripcion, tipo, premioMoneda));

    DBMS_OUTPUT.PUT_LINE('------------------------------------------------');
    DBMS_OUTPUT.PUT_LINE('Premio insertado');
    DBMS_OUTPUT.PUT_LINE('------------------------------------------------');
end;
/

create or replace procedure insertar_escala_a(idConcurso number, p_elemento varchar2, p_rangoinf number, p_rangosup number, p_clasif varchar2)
as
    premiosDePosExistentes number := 0;
begin

    -- TODO: Tal vez se deberia bloquear la insersion de valores negativos en los rangos

    INSERT INTO THE (SELECT escalas from Concurso where id = idConcurso) VALUES
    (escala(p_elemento, p_rangoinf, p_rangosup, p_clasif));

    DBMS_OUTPUT.PUT_LINE('------------------------------------------------');
    DBMS_OUTPUT.PUT_LINE('Escala insertada');
    DBMS_OUTPUT.PUT_LINE('------------------------------------------------');
end;
/

create or replace procedure agregar_organizador(idConcurso number, p_nombre varchar2, p_descripcion varchar2 DEFAULT null, fk_pais number)
as
    orgId number := ids_seq.nextval;
    poId number := ids_seq.nextval;
    orgConcId number := ids_seq.nextval;
begin

    insert into Organizador values (orgId, p_nombre, p_descripcion);

    insert into P_O values (poId, orgId, fk_pais);

    insert into Organizador_Concurso values (orgConcId, orgId, idConcurso);

    DBMS_OUTPUT.PUT_LINE('---------------------------------------------------------------------');
    DBMS_OUTPUT.PUT_LINE('Organizador creado y agregado a concurso (id = ' || to_char(orgId) || ')');
    DBMS_OUTPUT.PUT_LINE('P_O id: ' || to_char(poId) || ' - Organizador_Concurso id: ' || to_char(orgConcId));
    DBMS_OUTPUT.PUT_LINE('---------------------------------------------------------------------');
end;
/

create or replace procedure mostrar_organizadores(idConcurso number)
as
begin

    DBMS_OUTPUT.PUT_LINE('---------------------------------------------------------------------');

    for org in (
        select og.nombre
        from Organizador og, Organizador_Concurso oc
        where oc.fk_concurso = idConcurso
        and og.id = oc.fk_organizador
    ) loop

        DBMS_OUTPUT.PUT_LINE('Nombre organizador: ' || org.nombre);
    end loop;

    DBMS_OUTPUT.PUT_LINE('---------------------------------------------------------------------');
end;
/

create or replace function validar_concurso_internacional (idConcurso IN number)
return varchar2 is
    esInternacional varchar2(50);
    cont number := 0;
BEGIN
    for Pais in (select P.nombre from
                        P_O PO, Organizador O,Concurso C, Organizador_Concurso OC,Pais P where
                        PO.fk_organizador = O.id and Po.fk_pais = P.id and OC.fk_organizador = O.id
                        and OC.fk_concurso = idConcurso) loop

        if cont = 0 then
            esInternacional := Pais.nombre;
        elsif esInternacional <> Pais.nombre then
            esInternacional := 'S';
        end if;
        cont := cont + 1;
    end loop;
    return esInternacional;
END;
/

create or replace procedure insertar_calendario(
    p_id number default ids_seq.nextval,
    p_datosbanc datosBancarios,
    p_fechaLimEnvioDeInsc date,
    p_fechaLimiteRecepcionVinos date,
    p_fechaInicio date,
    p_fechaFin date,
    p_precioEstandarPorMuestra number,
    p_direccionEnvioMuestras direccion,
    p_lugarRealizar lugar,
    p_unidadMonetaria unidadMonetaria,
    p_emailEnvioInscripcion varchar2,
    p_datosDeContacto datosDeContacto,
    p_idConcurso number,
    p_idCatadorExp number
) as
    nombreJuez varchar2(100);
begin

    if (p_fechaFin < p_fechaInicio) then
        RAISE_APPLICATION_ERROR(-20106, 'La fecha fin no puede ser antes que la fecha de inicio');
    end if;

    if ( p_fechaLimEnvioDeInsc > p_fechaFin) then
        RAISE_APPLICATION_ERROR(-20107, 'La fecha de inscripcion no puede ser despues que la fecha final');
    end if;

    if p_precioEstandarPorMuestra < 0 then
        RAISE_APPLICATION_ERROR(-20104, 'El precio estandar no puede ser menor a cero');
    end if;

    begin
        select ce.nombre || ' ' || ce.apellido into nombreJuez
        from catadorExperto ce
        where ce.id = p_idCatadorExp;
    exception
        when NO_DATA_FOUND then
            RAISE_APPLICATION_ERROR(-20105, 'El experto indicado no esta registrado.');
    end;

    INSERT INTO Edicion VALUES (
        p_id,
        p_datosbanc,
        p_fechaLimEnvioDeInsc,
        p_fechaLimiteRecepcionVinos,
        p_fechaInicio,
        p_fechaFin,
        p_precioEstandarPorMuestra,
        p_direccionEnvioMuestras,
        costoInscripcion_nt(),
        p_lugarRealizar,
        p_unidadMonetaria,
        p_emailEnvioInscripcion,
        p_datosDeContacto,
        p_idConcurso
    );

    INSERT INTO Juez VALUES
    (p_idCatadorExp, p_id);

    DBMS_OUTPUT.PUT_LINE('------------------------------------------------');
    DBMS_OUTPUT.PUT_LINE('Edicion creada (id = ' || to_char(p_id) || ')');
    DBMS_OUTPUT.PUT_LINE('Juez ' || nombreJuez || ' asignado a edicion.');
    DBMS_OUTPUT.PUT_LINE('------------------------------------------------');

end;
/

create or replace procedure crear_precio_presentacion (
    idMarcaVino number,
    idPresentacion number,
    anio number,
    precio number
) as
    clasifVino number;
begin
    -- TODO: Validacion de anio vs fecha de cosecha?
    begin
        select fk_clasificacionvinos into clasifVino from MarcaVino where id = idMarcaVino;
    exception
      when no_data_found then
        RAISE_APPLICATION_ERROR(-20109, 'Clasificacion de vino no conseguida (critico, culpa nuestra)');
    end;
    if (precio <= 0) then
        RAISE_APPLICATION_ERROR(-20108, 'El precio de la presentacion no puede ser negativo o cero');
    end if;

    begin
        insert into HistoricoPrecio values
        (anio, idPresentacion, idMarcaVino, clasifVino, precio);

        DBMS_OUTPUT.PUT_LINE('------------------------------------------------');
        DBMS_OUTPUT.PUT_LINE('Precio agregado exitosamente');
        DBMS_OUTPUT.PUT_LINE('------------------------------------------------');
    exception
      when DUP_VAL_ON_INDEX then
        DBMS_OUTPUT.PUT_LINE('Error: Ya existe un historico de precio para este anio');
    end;

end;
/

create or replace procedure insertar_bodega(
    p_nombre varchar2,
    p_fechaFundacion date,
    p_datosDeContacto datosDeContacto,
    p_descripcionMision varchar2,
    p_descripcionGeneralVinos varchar2,
    p_propietario number default null,
    p_id number DEFAULT ids_seq.nextval
) as
begin

    insert into Bodega values (
        p_id,
        p_nombre,
        hechos_hist_nt(),
        p_fechaFundacion,
        p_datosDeContacto,
        p_descripcionMision,
        p_descripcionGeneralVinos,
        tipo_valor_nt(),
        distribucion_exp_nt(),
        p_propietario
    );

    DBMS_OUTPUT.PUT_LINE('------------------------------------------------');
    DBMS_OUTPUT.PUT_LINE('Bodega insertada (id = ' || to_char(p_id) || ')');
    DBMS_OUTPUT.PUT_LINE('------------------------------------------------');

end;
/
create or replace procedure insertar_costo_a(idEdicion number, p_nroMuestras number, p_valor number, p_pais varchar2) 
as
begin

    -- TODO: Validar que ya no se tenga un costo para el mismo pais y nro de muestras
    
    INSERT INTO THE (SELECT costos from Edicion where id = idEdicion) VALUES
    (costoInscripcion(p_nroMuestras, p_valor, p_pais));

    DBMS_OUTPUT.PUT_LINE('------------------------------------------------');
    DBMS_OUTPUT.PUT_LINE('Costo insertado');
    DBMS_OUTPUT.PUT_LINE('------------------------------------------------');
end;
/

create or replace procedure insertar_premio_a_vino(idMuestraC number,idFkInscripcion number,p_nombre varchar2, p_posicion number, p_descripcion varchar2, p_tipo varchar2,p_premioMoneda number)
as
    idConcurso number;
    existePremio char(1);
begin

    if p_premioMoneda < 0 then
        RAISE_APPLICATION_ERROR(-20200, 'El valor monetario del premio no puede ser negativo');
    end if;

    if p_posicion < 1 then
        RAISE_APPLICATION_ERROR(-20201, 'La posicion del premio no puede ser menor a 1');
    end if;

    select C.id into idConcurso from Concurso C, MuestraCompite M, Inscripcion I, Edicion E
        where E.id = I.fk_edicion and E.fk_concurso = C.id and M.id = idMuestraC and M.fk_inscripcion = idFkInscripcion
        and idFkInscripcion = I.id;

    for nombrePremio in (select t.nombre from the(select premios from Concurso where id = idConcurso) t ) loop
        if nombrePremio.nombre = p_nombre then
            existePremio := 'S';
            exit;
        end if;
    end loop;

    if existePremio is null then
        RAISE_APPLICATION_ERROR(-20203, 'El premio no existe en el concurso al que se esta inscribiendo');
    end if;

    INSERT INTO THE (SELECT premio from MuestraCompite where id = idMuestraC and fk_inscripcion = idFkInscripcion) VALUES
    (premio(p_nombre,p_posicion, p_descripcion, p_tipo,p_premioMoneda));

    DBMS_OUTPUT.PUT_LINE('------------------------------------------------');
    DBMS_OUTPUT.PUT_LINE('Premio insertado');
    DBMS_OUTPUT.PUT_LINE('------------------------------------------------');
end;
/

create or replace procedure formula_ventana_consumo(idMarcaVino number,idClasificacion number)
as
    ventanaAnio number;
    anioFinal number (4,0);
begin
    for VentanaConsumo in (select M.ventanaDeConsumoMeses , C.anio from
                            Cosecha C, MarcaVino_B_DO MB, MarcaVino M
                            where MB.fk_b_do = C.fk_bdo_id and MB.fk_bodega = C.fk_bdo_bodega and MB.fk_denominaciondeorigen = fk_bdo_do_id
                            and MB.fk_do_VariedadVid = C.fk_bdo_do_VariedadVid and MB.fk_do_region = C.fk_bdo_do_region and
                            MB.fk_marcavino = idMarcaVino and MB.fk_clasificacionvinos = idClasificacion and
                            M.id = MB.fk_marcavino and M.fk_clasificacionvinos = MB.fk_clasificacionvinos) loop

        ventanaAnio := trunc(VentanaConsumo.ventanaDeConsumoMeses/12);
        anioFinal := VentanaConsumo.anio + ventanaAnio;
        DBMS_OUTPUT.PUT_LINE('------------------------------------------------');
        DBMS_OUTPUT.PUT_LINE('Anio Incial: ' || to_char(VentanaConsumo.anio) || ' Anio Final : ' || to_char(anioFinal));
        DBMS_OUTPUT.PUT_LINE('------------------------------------------------');

    end loop;

end;
/

create or replace function premio_para_posicion(idConcurso number, p_posicion number)
return premio is
    result premio;
begin
    select premio(nt.nombre, nt.posicion, nt.descripcion, nt.tipo, nt.premioMoneda) into result 
    from the (select premios from Concurso where id = idConcurso) nt
    where nt.posicion = p_posicion;
    return result;
end;
/

create or replace procedure resultados_concurso (idEdicion number)
as
    esDeCatadores char(1);
    idConcurso number;
    cont number := 1;
    premioHolder premio;
begin
    select C.deCatadores, C.id into esDeCatadores, idConcurso from Concurso C, Edicion E
        where E.id = idEdicion and E.fk_concurso = C.id;

    if esDeCatadores = 'N' then

        for resultado in (select avg(C.sumatoria) RP,M.id Mid, I.id Iid, MV.nombre
                            from MuestraCompite M,CataExperto C, Inscripcion I,Edicion E,MarcaVino MV
                            where M.fk_inscripcion = I.id and I.fk_edicion = E.id and C.fk_muestracompite = M.id and E.id = idEdicion and
                            M.fk_marcavino = MV.id and M.fk_clasificacionvinos = MV.fk_clasificacionvinos
                            group by M.id,I.id,MV.nombre
                            order by avg(sumatoria) desc)
        loop
            begin
                premioHolder := premio_para_posicion(idConcurso, cont);
                DBMS_OUTPUT.PUT_LINE('Resultado Promedio: ' || to_char(resultado.RP, '999,999') || '| Posicion : ' || to_char(cont)|| ' | Nombre del vino: ' || resultado.nombre || ' (MuestraCompite id = ' || to_char(resultado.Mid) || ')');

                -- TODO: Tal vez esto deberia llamar a un procedure que asigne el premio y valide que ya no lo tenga, pero creo que si se puede repetir
                INSERT INTO THE (select premio from MuestraCompite where id = resultado.Mid and fk_inscripcion = resultado.Iid)
                VALUES (premio(premioHolder.nombre, premioHolder.posicion, premioHolder.descripcion, premioHolder.tipo, premioHolder.premioMoneda));

                DBMS_OUTPUT.PUT_LINE('------------------------------------------------');
            exception
              when no_data_found then
                DBMS_OUTPUT.PUT_LINE('');
            end;
           
            cont := cont+1;
        end loop;

    elsif esDeCatadores = 'S' then
      -- TODO: Implementar
      /* 
        Aqui es un beta como se pueden tener varias muestra compite en la misma edicion
         entonces hay que ir calculando la diferencia entre la sumatoriaExperta y la sumatoria
         de la cata aprendiz (valor absoluto) por muestra, y luego ganarian los que tengan la diferencia
         mas pequeña (conseguir premio usando la funcion premio_para_posicion(idConcurso, posicion) )
      */
    end if;
end;
/

create or replace function litros_a_hectolitros(litros number )
return number is
    hectolitros number;
begin
    hectolitros:= litros/100;
    return hectolitros;
end;
/

/* Consulta para sacar la producion en hectolitro por marca
select t.anio, litros_a_hectolitros(t.valor) as valor
from the (select produccionAnual from MarcaVino where id = idMarca)t;
*/

create or replace procedure insertar_muestra_catador(anada number, sumatoriaExperto number, idMarca number, idCatadorExperto number, idEdicion number)
as
--idEdicion number:= 0;
--idCatadorExperto number:= 0;
idClasificacionVino number:= 0;
cosechas number;
verificacion number := 0;
pid number := ids_seq.nextval;
begin

    -- TODO: Esto se repite un par de veces, hacer una funcion y llamarla en todos lados
    for cosechas in (Select c.anio From Cosecha c, B_DO b, MarcaVino_B_DO a Where c.fk_bdo_id = b.id and a.fk_b_do = b.id and a.fk_marcavino = idMarca )
    loop
        if cosechas.anio = anada then
            verificacion := 1;
            exit;
        end if;
    end loop;

    if verificacion = 0 then
        RAISE_APPLICATION_ERROR(-20200, 'La cosecha no existe en la marca de vino ingresada');
    end if;

    /*
    Select fk_edicion into idEdicion
    From Juez
    Where id = idJuez;

    Select fk_catadorexperto into idCatadorExperto
    From Juez
    Where id = idJuez;
    */

    Select fk_clasificacionvinos into idClasificacionVino
    From MarcaVino
    Where id = idMarca;

    INSERT INTO MuestraCatador VALUES (
      pid,
      idMarca,
      idClasificacionVino,
      idEdicion,
      idCatadorExperto,
      anada,
      sumatoriaExperto
    );
    DBMS_OUTPUT.PUT_LINE('------------------------------------------------');
    DBMS_OUTPUT.PUT_LINE('Muestra insertada (id = ' || to_char(pid) || ')');
    DBMS_OUTPUT.PUT_LINE('------------------------------------------------');


end;
/
create or replace procedure insertar_muestra_compite( anada number, idMarca number, idInscripcion number)
as
idClasificacionVino number:= 0;
cosechas number;
verificacion number := 0;
pid number := ids_seq.nextval;
begin

    for cosechas in (Select c.anio From Cosecha c, B_DO b, MarcaVino_B_DO a Where c.fk_bdo_id = b.id and a.fk_b_do = b.id and a.fk_marcavino = idMarca )
    loop
        if cosechas.anio = anada then
            verificacion := 1;
            -- Ya conseguimos el premio, salimos del loop de una vez para no recorrer todos los registros
            exit;
        end if;
    end loop;

    if verificacion = 0 then
        RAISE_APPLICATION_ERROR(-20200, 'La cosecha no existe en la marca de vino ingresada');
    end if;

    Select fk_clasificacionvinos into idClasificacionVino
    From MarcaVino
    Where id = idMarca;

    INSERT INTO MuestraCompite VALUES (
      pid,
      idMarca,
      idClasificacionVino,
      idInscripcion,
      anada,
      premio_nt()
    );
    DBMS_OUTPUT.PUT_LINE('------------------------------------------------');
    DBMS_OUTPUT.PUT_LINE('Muestra insertada (id = ' || to_char(pid) || ')');
    DBMS_OUTPUT.PUT_LINE('------------------------------------------------');


end;
/
create or replace procedure insertar_valoracion_experto(idCata number, nombreVal varchar2, valor number, observacion varchar2)
as
catas number;
begin
    insert into table (select valoraciones from CataExperto where id = idCata) values (nombreVal, valor, observacion);

    DBMS_OUTPUT.PUT_LINE('------------------------------------------------');
    DBMS_OUTPUT.PUT_LINE('Valoracion de experto insertada');
    DBMS_OUTPUT.PUT_LINE('------------------------------------------------');


end;
/
create or replace procedure insertar_valoracion_aprendiz(idCata number, nombreVal varchar2, valor number, observacion varchar2)
as
begin
    insert into table (select valoraciones from CataAprendiz where id = idCata) values (nombreVal, valor, observacion);

    DBMS_OUTPUT.PUT_LINE('------------------------------------------------');
    DBMS_OUTPUT.PUT_LINE('Valoracion de aprendiz insertada');
    DBMS_OUTPUT.PUT_LINE('------------------------------------------------');


end;
/
create or replace procedure actualizar_premio_inscripcion(idInscripcion number, nombrePremio varchar2)
as
idEdicion number;
verificacion number:=0;
-- PILLA: Esta variable se llama igual a la del loop, y creo que no se usa
nombresDePremios varchar2(60);
begin
    select e.fk_concurso into idEdicion from Edicion e, Inscripcion i where i.id = idInscripcion and i.fk_edicion = e.id;
    for nombresDePremios in (select a.nombre from Concurso c CROSS JOIN TABLE(c.premios) a where c.id = idEdicion)
    loop
        if nombresDePremios.nombre = nombrePremio then
            verificacion := 1;
            -- Ya conseguimos el premio, salimos del loop de una vez
            exit;
        end if;
    end loop;

    if verificacion = 0 then
        RAISE_APPLICATION_ERROR(-20200, 'El premio no existe en el concurso');
    end if;

    -- PILLA: Me parece raro que el premio en la inscripcion sea el nombre nada mas
    --        Como en muestra compite es un NT de premio, creo que aqui tambien se
    --        deberia guardar el tipo premio, pero uno solo
    update Inscripcion set premioCatador = nombrePremio where id = idInscripcion;

    DBMS_OUTPUT.PUT_LINE('------------------------------------------------');
    DBMS_OUTPUT.PUT_LINE('Premio insertado');
    DBMS_OUTPUT.PUT_LINE('------------------------------------------------');
end;
/
create or replace procedure agregar_juez(idCatador number, idEdicion number)
as
identificadores number;
verificacion number := 0;
pid number := ids_seq.nextval;
begin
    select count(*) into verificacion from Juez where fk_edicion = idEdicion and fk_catadorexperto = idCatador;
    if verificacion > 0 then
        RAISE_APPLICATION_ERROR(-20200, 'Ese catador ya fue registrado como juez en esa edicion');
    end if;
    insert into Juez values (idCatador, idEdicion);

    DBMS_OUTPUT.PUT_LINE('------------------------------------------------');
    DBMS_OUTPUT.PUT_LINE('Juez asignado a edicion');
    DBMS_OUTPUT.PUT_LINE('------------------------------------------------');
end;
/
create or replace procedure inscribir_bodega(idBodega number, idEdicion number)
as
tipoDeConcurso char(1);
pid number := ids_seq.nextval;
begin
    select c.deCatadores into tipoDeConcurso from Concurso c, Edicion e where e.id = idEdicion and e.fk_concurso = c.id;
    if tipoDeConcurso = 'S' then
        RAISE_APPLICATION_ERROR(-20200, 'El concurso al que intenta inscribir una bodega es un concurso de catadores');
    end if;
    insert into inscripcion values (pid, CURRENT_DATE, null, idEdicion, idBodega, null);

    DBMS_OUTPUT.PUT_LINE('------------------------------------------------');
    DBMS_OUTPUT.PUT_LINE('Bodega inscrita en la edicion');
    DBMS_OUTPUT.PUT_LINE('------------------------------------------------');
end;
/
create or replace procedure inscribir_catador(idCatador number, idEdicion number)
as
tipoDeConcurso char(1);
catadorExiste number :=0 ;
pid number := ids_seq.nextval;
begin
    select c.deCatadores into tipoDeConcurso from Concurso c, Edicion e where e.id = idEdicion and e.fk_concurso = c.id;
    if tipoDeConcurso = 'N' then
        RAISE_APPLICATION_ERROR(-20200, 'El concurso al que intenta inscribir un catador es un concurso de bodegas');
    end if;
    select count(*) into catadorExiste from CatadorAprendiz where pasaporte = idCatador;
    if catadorExiste = 0 then
        RAISE_APPLICATION_ERROR(-20201, 'El catador que intenta inscribir no existe. Por favor registrarlo primero');
    end if;
    insert into inscripcion values (pid, CURRENT_DATE, null, idEdicion, null, idCatador);

    DBMS_OUTPUT.PUT_LINE('------------------------------------------------');
    DBMS_OUTPUT.PUT_LINE('Catador inscrito en la edicion');
    DBMS_OUTPUT.PUT_LINE('------------------------------------------------');
end;
/
create or replace procedure insertar_catador_aprendiz(pasaporte number, nombre varchar2, apellido varchar2, fecha varchar2, genero varchar2, ciudad varchar2, pais varchar2)
as
begin
    insert into CatadorAprendiz values (pasaporte, nombre, apellido, TO_DATE(fecha, 'DD/MM/YYYY'), genero, lugar(ciudad, pais));

    DBMS_OUTPUT.PUT_LINE('------------------------------------------------');
    DBMS_OUTPUT.PUT_LINE('Catador aprendiz registrado');
    DBMS_OUTPUT.PUT_LINE('------------------------------------------------');
end;
/

create or replace function calcular_porcentaje_vinedo (idPais number,anioP number)
return number is 
    porcentaje number(10,2) := 0;
    totalsuperficie number := 0;
    superficie number := 0;
begin
    for idP in (select id from Pais) loop
        select t.valor into superficie from 
        the(select superficieVinedo from pais where id = idP.id)t where t.anio = anioP;

        if superficie != 0  then
            totalsuperficie := totalsuperficie + superficie;
        end if;
    end loop;
    select t.valor into superficie from 
    the(select superficieVinedo from pais where id = idPais)t where t.anio = anioP;

    porcentaje := superficie/totalsuperficie * 100;
    return porcentaje;
end;
/
