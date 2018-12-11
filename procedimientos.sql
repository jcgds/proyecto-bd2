ALTER SESSION SET CURRENT_SCHEMA=WINE_SCHEMA;
/
create or replace procedure saludar(nombre varchar2) as
begin
    DBMS_OUTPUT.PUT_LINE('Hola ' || nombre || '!');
end;
/
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

/*
    Este procedimiento se encarga de calcular y actualizar los valores de produccion
    segun la produccion de sus marcas de vino.
    Al ser ejecutado elimina todos los registros de las NT produccionAnual de las
    bodegas y los reemplaza calculando de nuevo la produccion segun las marcas de vino
    entre el año minimo y maximo.
*/
create or replace procedure calcular_produccion_bodegas as
anio_min number := conseguir_anio_minimo();
anio_max number := select to_char(sysdate, 'YYYY') from dual;
acumulador1 number := 0;
begin    
    << bodegas_loop >>
    for bodega in (select id, nombre from Bodega)
    loop
        DBMS_OUTPUT.PUT_LINE('Bodega ' || bodega.nombre || ' | ' || to_char(bodega.id));
        -- Limpiar produccionAnual de la bodega pues la vamos a calcular de cero
        DELETE FROM THE (select vv.produccionAnual from Bodega vv where vv.id = bodega.id);
        
         -- Loop entre esos años
        -- Ir sumando la produccion de las marcas de vino de la bodega en ese año
        << year_loop >>
        for i in anio_min .. anio_max loop
            acumulador1 := 0;
            << marcas_loop >>
            for marca in (
                    select distinct mv.id
                    from MarcaVino_B_DO mvbdo, MarcaVino mv
                    where mvbdo.fk_bodega = bodega.id
                        and mvbdo.fk_marcavino = mv.id
                        and mvbdo.fk_clasificacionvinos = mv.fk_clasificacionvinos)
            loop
                acumulador1 := acumulador1 + produccion_marca_en(marca.id, i);
            end loop marcas_loop;
            
            DBMS_OUTPUT.PUT_LINE('Produccion year ' || TO_CHAR(i) || ' es: ' || to_char(acumulador1));
            -- Guardar en produccionAnual de la Bodega este valor
            INSERT INTO THE (select vv.produccionAnual from Bodega vv where vv.id = bodega.id)
            values (tipo_valor(i, acumulador1, 'litros'));
            
        end loop year_loop;  
    end loop bodegas_loop;  
end;
/

