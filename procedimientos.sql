create or replace procedure saludar(nombre varchar2) as
begin
  dbms_output.put_line('Hola ' || nombre || '!');
end;
/