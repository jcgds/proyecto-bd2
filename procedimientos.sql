ALTER SESSION SET CURRENT_SCHEMA=WINE_SCHEMA;
/
create or replace procedure saludar(nombre varchar2) as
begin
    DBMS_OUTPUT.PUT_LINE('Hola ' || nombre || '!');
end;
/
create or replace function produccion_bodega_en (idBodega IN number, anioDeseado IN number)
return number is 
    produccion number := 0;
BEGIN
   
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