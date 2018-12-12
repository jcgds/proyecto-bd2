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
   -- TODO: Rehcaer este metodo para que solo use su NT de produccionAnual
    FOR rec IN (select t.anio anio, t.valor valor
        from the (
            select mv.produccionAnual 
            from Marcavino mv, MarcaVino_B_DO mvbdo
            where mvbdo.fk_bodega = idBodega
                and mvbdo.fk_marcavino = mv.id  
                and mvbdo.fk_clasificacionvinos = mv.fk_clasificacionvinos
        ) t
        where t.anio = anioDeseado)
    LOOP
        -- DBMS_OUTPUT.PUT_LINE ('Anio: ' || TO_CHAR(rec.anio) || ' Prod: ' || TO_CHAR(rec.valor));
        produccion := produccion + rec.valor;
    END LOOP;
    
    return produccion;
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
    y exportacion de todas las bodegas segun la produccion de sus marcas de vino.
    
    Al ser ejecutado elimina todos los registros de las NT produccionAnual y exportacionAnual 
    de las bodegas y los reemplaza calculando de nuevo la produccion y exportacion segun las 
    marcas de vino entre el año minimo y maximo.
*/
create or replace procedure calcular_produccion_bodegas as
anio_min number := conseguir_anio_minimo();
anio_max number;
acumulador1 number := 0;
type pais_exportacion is table of number index by varchar2(50);
distribucionExp pais_exportacion;
paisIndex varchar2(50);
begin    
    select to_char(sysdate, 'YYYY') into anio_max from dual;
    << bodegas_loop >>
    for bodega in (select id, nombre from Bodega)
    loop
        DBMS_OUTPUT.PUT_LINE('Bodega ' || bodega.nombre || ' | ' || to_char(bodega.id));

        DELETE FROM THE (select vv.produccionAnual from Bodega vv where vv.id = bodega.id);
        DELETE FROM THE (select vv.exportacionAnual from Bodega vv where vv.id = bodega.id);

        -- Recorremos los años y vamos sumando la produccion de las marcas de vino de la bodega en ese año
        << year_loop >>
        for i in anio_min .. anio_max loop
            acumulador1 := 0;
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
                -- Vamos sumando la produccion de las marcas en el acumulador de la bodega
                acumulador1 := acumulador1 + produccion_marca_en(marca.id, i);
                
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
            
            DBMS_OUTPUT.PUT_LINE('Produccion year ' || TO_CHAR(i) || ' es: ' || to_char(acumulador1));
              
            -- Guardar en produccionAnual de la Bodega este valor
            INSERT INTO THE (select vv.produccionAnual from Bodega vv where vv.id = bodega.id)
            values (tipo_valor(i, acumulador1, 'litros'));
            
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

