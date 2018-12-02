--ALTER SESSION SET CURRENT_SCHEMA=WINE_SCHEMA;

create or replace procedure saludar(nombre varchar2) as
begin
    DBMS_OUTPUT.PUT_LINE('Hola ' || nombre || '!');
end;

