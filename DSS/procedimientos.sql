create or replace procedure Extraer as
anio_max number := EXTRACT(year from sysdate);
anio_min number := anio_max - 3;
idForPaisAux number;
idForBodega number;
idForMarca number;
idForCritica number;
begin

  << anio_loop >>
  for anio in anio_min .. anio_max loop

      begin
        insert into I_tiempoAux values (anio);
      exception
        when DUP_VAL_ON_INDEX then
            DBMS_OUTPUT.PUT_LINE('Informacion del ' || to_char(anio) || ' ya extraida.');
            continue;
      end;

    <<paises_loop>>
    for recPais in (select p.id, p.nombre, p.continente, produccion_pais_en(p.id, anio) prod, CalcularExportacionPais(p.id, anio) exportacion from Pais p)
    loop
        idForPaisAux := seq_Imetricas_pais.nextval;
        DBMS_OUTPUT.PUT_LINE('ID: ' || to_char(idForPaisAux) || ' Nombre Pais: ' || recPais.nombre || ' Prod: ' || to_char(recPais.prod) || ' Exp: ' || to_char(recPais.exportacion));
        INSERT INTO I_paisAux VALUES (idForPaisAux, anio, recPais.nombre, recPais.continente, recPais.prod, recPais.exportacion);

        <<bodegas_loop>>
        for recBodega in (
            select distinct bo.id, bo.nombre, produccion_bodega_en(bo.id, anio) prod, exportacion_bodega_en(bo.id, anio) exportacion
            from B_DO bdo, Pais p, Region r, DenominacionDeOrigen do, Bodega bo
            where r.fk_pais = recPais.id
            and do.fk_region = r.id
            and bdo.fk_do_id = do.id
            and bdo.fk_do_region = do.fk_region
            and bdo.fk_do_variedadvid = do.fk_variedadvid
            and bdo.fk_bodega = bo.id
        ) loop

            idForBodega := seq_Icontinente.nextval;
            INSERT INTO I_bodega VALUES (idForBodega, idForPaisAux, anio, recBodega.nombre, recBodega.prod, recBodega.exportacion);

            <<marca_loop>>
            for recMarca in (
                select distinct M.id, M.nombre, produccion_marca_en(M.id, anio) produccion, exportacion_marca_en(M.id, anio) exportacion, premios_marca_en(M.id, anio) nPremios
                from MarcaVino M, MarcaVino_B_DO MB,Bodega B
                where B.id = MB.fk_bodega and M.id = MB.fk_marcavino and B.id = recBodega.id
            ) loop
                idForMarca := seq_Itiempo.nextval;
                DBMS_OUTPUT.PUT_LINE('ID: ' || to_char(recMarca.id) || ' Nombre Marca: ' || recMarca.nombre || ' Prod: ' || to_char(recMarca.produccion) || ' Exp: ' || to_char(recMarca.exportacion) || ' Premios: ' || to_char(recMarca.nPremios));
                insert into I_marca values (idForMarca, idForBodega, anio, recMarca.nombre, recMarca.produccion, recMarca.exportacion, recMarca.nPremios);

                << criticas_loop >>
                for recCritica in (select xx.* from the (select mm.criticas from MarcaVino mm where mm.id = recMarca.id) xx where xx.valor.anio = anio)
                loop
                    DBMS_OUTPUT.PUT_LINE('Critica: ' || recCritica.nombreCritica || ' Anio: ' || to_char(recCritica.valor.anio) || ' Valor: ' || to_char(recCritica.valor.valor));
                    idForCritica := seq_Itiempo.nextval;
                    INSERT INTO I_critica VALUES (idForCritica, idForMarca, recCritica.valor.valor);

                end loop criticas_loop;

            end loop marca_loop;

        end loop bodegas_loop;

    end loop paises_loop;


    << catador_loop >>
    for recCatador in (
        select ca.nombre || ' ' || ca.apellido nombre, ca.pasaporte,
           (select count(*)
           from Inscripcion i where i.fk_catadoraprendiz = ca.pasaporte
           and i.premioCatador is not null
           and EXTRACT(year from i.fecha) = anio
           ) nPremios
        from CatadorAprendiz ca
    ) loop

        INSERT INTO I_Catador VALUES (seq_Ipais.nextval, anio, recCatador.nombre, recCatador.pasaporte, recCatador.nPremios);

    end loop catador_loop;

    << concurso_loop >>
    for recConcurso in (
        select co.nombre, co.deCatadores, (
            select count(i.id)
            from Edicion e, Inscripcion i
            where e.fk_concurso = co.id
            and i.fk_edicion = e.id
            and EXTRACT(year from i.fecha) = anio
        ) inscripciones
        from Concurso co
    ) loop

        INSERT INTO I_Concurso VALUES (seq_Itipo_concurso.nextval, anio, recConcurso.nombre, recConcurso.inscripciones, recConcurso.deCatadores);

    end loop concurso_loop;

  end loop anio_loop;

end;
/

create or replace procedure Limpiar as
begin
    delete from I_critica;
    delete from I_marca;
    delete from I_bodega;
    delete from I_paisAux;
    delete from I_concurso;
    delete from I_catador;
end;
/

create or replace function premios_marca_en(idMarcaOLTP number, anio number)
return number is
    n_premios number;
begin
    select COUNT(*) into n_premios
    from muestraCompite c, marcaVino mv, Inscripcion i
    where mv.id = idMarcaOLTP and c.premio is not empty
    and mv.id = c.fk_marcavino
    and i.id = c.fk_inscripcion
    and EXTRACT(year from i.fecha) = anio;

    return n_premios;
end;
/
---------------- Funcion para saber si ese año y bienio existen en el area intermedia y sino que lo cree ----------------
create or replace function Buscartiempo(p_anio number)
return number is
    tiempo number;
    existe number;
    p_bienio number;
begin
    p_bienio := p_anio - 2016;
    if (p_bienio = 0) then
        p_bienio := 1;
    end if;
    select count(*) into existe from I_tiempo t where t.anio = p_anio;
    if (existe = 0) then
        insert into I_tiempo values(seq_Itiempo.nextval, p_anio, p_bienio);
    end if;
    select t.id into tiempo from I_tiempo t where t.anio = p_anio;
    return tiempo;
end;
/
---------------- Funcion que dado el id de un pais en el area intermedia, busca, y crea de ser necesario, el pais en el modelo estrella -----------------
create or replace function BuscarPais(f_nombre varchar, f_continente varchar)
return number is
existe number := 0;
pais number;
begin
    select count(*) into existe from I_pais p where p.nombre = f_nombre;
    if (existe = 0) then
        insert into I_pais values(seq_Ipais.nextval, f_continente, f_nombre, SYSDATE);
    end if;
    select p.id into pais from I_pais p where p.nombre = f_nombre;
    return pais;
end;
/
--------------- Saca el top de paises exportadores y de paises productores para un año dado -----------------------------
create or replace procedure TransformacionTopProdExpo (anio number)
as
cont number:=1;
existe number(1):=0;
tiempo number(10) := 0;
name varchar(50);
export number(10):=0;
idMetrica number;
top1E varchar(50);
top2E varchar(50);
top1P varchar(50);
top2P varchar(50);
top3P varchar(50);
begin

    tiempo:=BuscarTiempo(anio);

    for names in (select p.nombre into name from (select nombre, exportacion from I_paisAux where id_tiempoAux = anio order by exportacion DESC) p where rownum<=2) loop
        if (cont = 1) then
            top1E:=names.nombre;
        end if;
        if (cont = 2) then
            top2E:=names.nombre;
        end if;
        cont:=cont+1;
    end loop;

    cont :=1;

     for names in (select p.nombre into name from (select nombre, produccion from I_paisAux where id_tiempoAux = anio order by produccion DESC) p where rownum<=3) loop
        if (cont = 1) then
            top1P:=names.nombre;
        end if;
        if (cont = 2) then
            top2P:=names.nombre;
        end if;
        if (cont = 3) then
            top3P:=names.nombre;
        end if;
        cont:=cont+1;
    end loop;


    idMetrica := seq_Imetricas_pais.nextval;
    insert into I_metricas_pais values (idMetrica, tiempo, null, null, top1P, top2P, top3P, null, null, top1E, top2E, null, null, null, null, null, null, null, null, null);

end;
/
---------------------Top bodegas por produccion -------------------

Create or replace procedure TransformacionTopBodega(anio number) as
tiempo number;
pais number;
top1 varchar(50);
top2 varchar(50);
cont number:=1;
begin
    tiempo := buscarTiempo(anio);
    for idpaises in (select p.id, p.nombre, p.continente from I_paisAux p where p.id_tiempoAux = anio) loop
        pais:=BuscarPais(idpaises.nombre, idpaises.continente);
        for bodegas in (select f.nombreBod
        from (Select b.nombre nombreBod, b.produccion prodbod from I_bodega b where b.id_tiempoAux = anio and b.id_paisAux = idpaises.id
        order by b.produccion DESC) f
        where rownum<=2) loop
            if (cont = 1) then
                top1:=bodegas.nombreBod;
            else
                top2:=bodegas.nombreBod;
            end if;
            cont:=cont+1;
        end loop;
        cont:=1;
        insert into I_metricas_pais (id, id_tiempo, id_lugar, top1_bodega_prod, top2_bodega_prod) values (seq_Imetricas_pais.nextval, tiempo, pais, top1, top2);
    end loop;
end;
/
