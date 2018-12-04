SET SERVEROUTPUT ON;
ACCEPT idBodega NUMBER PROMPT 'Introduzca el ID de la bodega: ';
ACCEPT desde NUMBER PROMPT 'Introduzca el anio inicial: ';
ACCEPT hasta NUMBER PROMPT 'Introduzca el anio final: ';

create or replace procedure produccion_anual_bodega as
    produccion number;
    idbod number := &idBodega;
    desde number := &desde;
    hasta number := &hasta;
begin
    FOR i IN desde .. hasta LOOP
        produccion := produccion_bodega_en(idbod, i);
        DBMS_OUTPUT.PUT_LINE(TO_CHAR(i) || ': ' || TO_CHAR(produccion));
    END LOOP;
end;
/
execute produccion_anual_bodega();