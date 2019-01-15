create or replace procedure Extraer as
-- 2018 porque es el ultimo año con registros, en 2019 todas los numeros dan 0
anio_max number := 2018; --EXTRACT(year from sysdate);
anio_min number := anio_max - 2;
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

/*
    Basado en la tabla I_TiempoAux, extrae los bienios y llena
    la dimension tiempo en el modelo estrella del AI
*/
create or replace procedure TransformarTiempo as
ai_anio_min number;
ai_anio_max number;
contador number := 1;
bienio number := 1;
begin
    
    select MIN(anio) into ai_anio_min from I_TiempoAux;
    select MAX(anio) into ai_anio_max from I_TiempoAux;

    DBMS_OUTPUT.PUT_LINE('Primer anio AI: ' || to_char(ai_anio_min));
    DBMS_OUTPUT.PUT_LINE('Ultimo anio AI: ' || to_char(ai_anio_max));

    for i in ai_anio_min .. ai_anio_max loop
      
        DBMS_OUTPUT.PUT_LINE('I_Tiempo(id, ' || to_char(i) || ', ' || to_char(bienio) || ')');
        INSERT INTO I_Tiempo VALUES (seq_Itiempo.nextval, i, bienio);

        if contador = 2 then
            bienio := bienio + 1;
            DBMS_OUTPUT.PUT_LINE('I_Tiempo(id, ' || to_char(i) || ', ' || to_char(bienio) || ')');
            INSERT INTO I_Tiempo VALUES (seq_Itiempo.nextval, i, bienio);
            contador := 1;
        end if;

        contador := contador + 1;
    end loop;

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
existeE number := 0;
pais number;
begin
    select count(*) into existe from I_pais p where p.nombre = f_nombre;
    if (existe = 0) then
        insert into I_pais values(seq_Ipais.nextval, f_nombre, SYSDATE);
        select count(*) into existeE from I_continente p where p.nombre = f_continente;
        if (existeE = 0) THEN
          insert into I_continente values (seq_Icontinente.nextval, f_continente, SYSDATE);
        end if;
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
        top1:= '';
        top2:= '';
    end loop;
end;
/

/*
    Devuelve el porcentaje de variacion entre valor inicial y final
*/
create or replace function Variacion(p_valor_inicial number, p_valor_final number) 
return number is
begin
    if p_valor_inicial = 0 then
        return null;
    end if;

    return ((p_valor_final/p_valor_inicial) - 1) * 100;
end;
/


create or replace function produccion_pais_en_anio(anio number, nombrePais varchar2) return number is
produccionN number;
begin
  
    begin
        select produccion into produccionN from I_PaisAux where nombre = nombrePais and id_tiempoAux = anio;  
    exception
        when no_data_found then
            return 0;
    end;

    return produccionN;
end;
/

/*
    Devuelve la produccion total del pais en el bienio indicado.
    Es decir, suma la produccion de los años que conforman el bienio
*/
create or replace function produccion_pais_en_bienio(p_bienio number, nombrePais varchar2) return number is
anio1 number;
anio2 number;
begin
    -- Agarrar anios de bienio en I_Tiempo
    select MIN(anio) into anio1 from I_Tiempo where bienio = p_bienio;
    anio2 := anio1 + 1;

    -- Conseguir produccion en I_PaisAux en esos anios
    return produccion_pais_en_anio(anio1, nombrePais) + produccion_pais_en_anio(anio2, nombrePais);
end;
/

/*
    Metrica> %crecimientoproducción por país (año y bienios)
    Depende de que ya se haya llenado la tabla I_Tiempo en el AI.
*/
create or replace procedure TransformarCrecimientoPais as
produccionAnualInicial number;
produccionAnualFinal number;
porcentajeAnual number;
porcentajeBienio number;
idPaisHolder number;
begin
  
    -- Recorremos los años y bienos que debieron ser previamente calculados
    -- con el procedimiento TransformarTiempo
    << time_loop >>
    for recTiempo in (
        select id, anio, bienio
        from i_tiempo
        order by anio asc, bienio asc
    ) loop
        
        << pais_loop >>
        for recPaisAux in (
            select distinct nombre, continente from I_PaisAux
        ) loop
            
            -- Si la dimension Pais no existe, agregar
            begin 
                select id into idPaisHolder from I_pais where nombre = recPaisAux.nombre;
            exception
              when no_data_found then
                idPaisHolder := seq_Ipais.nextval;
                INSERT INTO I_Pais VALUES (idPaisHolder, recPaisAux.nombre, sysdate);
            end;

            produccionAnualInicial := produccion_pais_en_anio(recTiempo.anio - 1, recPaisAux.nombre);
            produccionAnualFinal := produccion_pais_en_anio(recTiempo.anio, recPaisAux.nombre);

            -- Si no hay produccion inicial, el crecimiento es infinito
            if produccionAnualInicial = 0 then
                porcentajeAnual := null;
            else
                porcentajeAnual := variacion(produccionAnualInicial, produccionAnualFinal);
            end if;

            porcentajeBienio := variacion(
                produccion_pais_en_bienio(recTiempo.bienio - 1, recPaisAux.nombre),
                produccion_pais_en_bienio(recTiempo.bienio, recPaisAux.nombre)
            );

            INSERT INTO I_metricas_pais (id, id_tiempo, id_lugar, PorcCrecimiento_prod_anual, PorcCrecimiento_prod_bienio) 
            VALUES (
                seq_Imetricas_pais.nextval,
                recTiempo.id,
                idPaisHolder,
                porcentajeAnual,
                porcentajeBienio
            );
            
            
        end loop pais_loop;
    end loop time_loop;

end;
/

create or replace procedure TransformarConcursoMasPopular as
nombreConcurso varchar2(200);
begin

    << time_loop >>
    for recTiempo in (
        select id, anio, bienio
        from i_tiempo
        order by anio asc, bienio asc
    ) loop
        begin
            select x.nombre into nombreConcurso
            from (
                select nombre, inscripciones 
                from I_Concurso 
                where id_tiempoAux = recTiempo.anio
                and tipoConcurso like 'S'
                order by inscripciones desc
            ) x
            where rownum <= 1;

            INSERT INTO I_metricas_concurso (id, id_tiempo, ConcursoMasPopular) VALUES (
                seq_Imetricas_concurso.nextval,
                recTiempo.id,
                nombreConcurso
            );
        exception
          when no_data_found then
            DBMS_OUTPUT.PUT_LINE('Ningun concurso tuvo inscripciones este año');
        end;

    end loop time_loop;

end;
/

create or replace procedure Transformar as
begin
    TransformarTiempo();
    -- TODO: Agregar las demas transformaciones
    TransformarCrecimientoPais();
    TransformarConcursoMasPopular();
end;
/

create or replace procedure Transportar as
fecha_transporte date := sysdate;
anio number;
bienio number;
tiempoId number;
continenteId number;
paisId number;
begin

    INSERT INTO DW_Tiempo (id, anio, bienio)
        select seq_tiempo.nextval, xx.anio, xx.bienio
        from (
            select anio, bienio
            from I_Tiempo
            MINUS
            select anio, bienio
            from DW_Tiempo
        ) xx;

    INSERT INTO DW_Pais (id, nombre, fecha_creacion)
    select seq_pais.nextval, xx.nombre, fecha_transporte
    from (
        select nombre
        from I_Pais
        MINUS
        select nombre
        from DW_Pais
    ) xx;

    for rec in (select * from I_metricas_pais) loop
        
        -- Aqui pretendia luego hacer un select para conesguir el id del DW_Tiempo para pasarlo al insert
        select anio, bienio into anio, bienio from I_Tiempo where id = rec.id_tiempo;


        INSERT INTO DW_metricas_pais VALUES (
            seq_metricas_pais.nextval,

        );

    end loop;
end;
/

-------- Top 5 marcas de vino () ------ 
Create or replace procedure TransformacionTopMarcaTotalP(anio number) as
tiempo number;
pais number;
top1 varchar(50);
top2 varchar(50);
top3 varchar(50);
top4 varchar(50);
top5 varchar(50);
cont number:=1;
begin
    tiempo := buscarTiempo(anio);
    ---- Por Pais ---- 
    for idpaises in (select p.id, p.nombre, p.continente from I_paisAux p where p.id_tiempoAux = anio) loop
        pais:=BuscarPais(idpaises.nombre, idpaises.continente);
        for marcas in (select M.nombre, M.produccion from i_marca M, i_paisaux P,i_bodega B 
                        where P.id = idPaises.id and P.id_tiempoaux = anio and B.id_paisaux = P.id and B.id = M.id_bodega
                        order by M.produccion DESC) loop
            if (cont = 1) then
                top1:=marcas.nombre;
            elsif (cont = 2) then
                top2:=marcas.nombre;
            elsif (cont = 3) then
                top3:=marcas.nombre;
            elsif (cont = 4) then
                top4:=marcas.nombre;
            elsif (cont = 5) then
                top5:=marcas.nombre;      
            end if;
            cont:=cont+1;
        end loop;
        cont:=1;
        insert into I_metricas_pais (id, id_tiempo, id_lugar, top1_marcavino_totalprod, top2_marcavino_totalprod,top3_marcavino_totalprod,
        top4_marcavino_totalprod,top5_marcavino_totalprod) 
        values (seq_Imetricas_pais.nextval, tiempo, pais, top1, top2,top3,top4,top5);
        top1:= '';
        top2:= '';
        top3:= '';
        top4:= '';
        top5:= '';
    end loop;
    cont:= 1;
    top1:= '';
    top2:= '';
    top3:= '';
    top4:= '';
    top5:= '';
    --------- Por Continente ----------
    for continentes in (select id,nombre from i_continente) loop
        for marcas in (select x.nombre from 
                    (select M.nombre , M.produccion from i_marca M, i_bodega B, i_paisaux P 
                    where P.id_tiempoaux = anio and  P.continente = continentes.nombre and P.id = B.id_paisaux and M.id_bodega = B.id
                    order by M.produccion DESC) x where rownum <=5) loop
            if (cont = 1) then
                top1:=marcas.nombre;
            elsif (cont = 2) then
                top2:=marcas.nombre;
            elsif (cont = 3) then
                top3:=marcas.nombre;
            elsif (cont = 4) then
                top4:=marcas.nombre;
            elsif (cont = 5) then
                top5:=marcas.nombre;      
            end if;
            cont:=cont+1;
        end loop;
        cont:=1;
        insert into I_metricas_pais (id, id_tiempo, id_continente, top1_marcavino_totalprod, top2_marcavino_totalprod,top3_marcavino_totalprod,
        top4_marcavino_totalprod,top5_marcavino_totalprod) 
        values (seq_Imetricas_pais.nextval, tiempo, continentes.id, top1, top2,top3,top4,top5);
        top1:= '';
        top2:= '';
        top3:= '';
        top4:= '';
        top5:= '';
    end loop;
end;
/

----- Top 3 marcas por pais (valoracion de criticos) ------
create or replace procedure TransformacionTopMarcaC (anio number) as 
tiempo number;
pais number;
top1 varchar(50);
top2 varchar(50);
top3 varchar(50);
cont number:=1;
countValues number;
begin
    tiempo := buscarTiempo(anio);
    top1:= '';
    top2:= '';
    top3:= '';
    for idpaises in (select p.id, p.nombre, p.continente from I_paisAux p where p.id_tiempoAux = anio) loop
        pais:=BuscarPais(idpaises.nombre, idpaises.continente);
        select count(x.id) into countValues from (select M.id,M.nombre ,AVG(C.valor) AS prom from i_marca M, i_paisAux P, i_bodega B, i_critica C where
                        M.id_bodega = B.id and B.id_paisaux = P.id and C.id_marca = M.id and M.id_tiempoaux = anio and P.id = idpaises.id
                        group by M.id,M.nombre order by prom DESC) x where rownum <=3;
        for marcas in (select x.nombre from (select M.id,M.nombre ,AVG(C.valor) AS prom from i_marca M, i_paisAux P, i_bodega B, i_critica C where
                        M.id_bodega = B.id and B.id_paisaux = P.id and C.id_marca = M.id and M.id_tiempoaux = anio and P.id = idpaises.id
                        group by M.id,M.nombre order by prom DESC) x where rownum <=3) loop
                if (cont = 1) then
                    top1:=marcas.nombre;
                elsif (cont = 2) then
                    top2:=marcas.nombre;
                elsif (cont = 3) then
                    top3:=marcas.nombre;    
                end if;
                cont:=cont+1;              
        end loop;
        cont:=1;
        if countValues > 0 then
            insert into I_metricas_pais (id, id_tiempo, id_lugar,top1_marcas_criticas,top2_marcas_criticas,top3_marcas_criticas ) 
            values (seq_Imetricas_pais.nextval, tiempo, pais, top1, top2,top3);
        end if;
        top1:= '';
        top2:= '';
        top3:= '';
    end loop;
         
end;
/

