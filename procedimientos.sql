ALTER SESSION SET CURRENT_SCHEMA=WINE_SCHEMA;

create or replace procedure insertar_concurso(nombre varchar2, dc datosDeContacto, tipoCata varchar2, deCatadores char, caracteristicas varchar2) as
begin
  INSERT INTO Concurso VALUES (
      ids_seq.nextval,
      nombre, 
      dc, 
      tipoCata,
      deCatadores,
      premio_nt(),
      escala_nt(),
      caracteristicas
  );
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
    Consigue el año más pequeño (más viejo) revisando todos los registros
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
    vino entre el año minimo y maximo.
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

        -- Recorremos los años y vamos sumando la produccion de las marcas de vino de la bodega en ese año
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
    vino y pais entre el año minimo y maximo.
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

        -- Recorremos los años y vamos sumando la produccion de las marcas de vino de la bodega en ese año
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
                -- en el año del loop
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
