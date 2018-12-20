SET SERVEROUTPUT ON;
SET VERIFY OFF;

ACCEPT concursoid PROMPT 'Ingrese el id del concurso: ';
ACCEPT i_nombre PROMPT 'Ingrese el nombre del organizador: ';
ACCEPT i_desc PROMPT 'Ingrese la descripcion del organizador: ';
ACCEPT i_pais PROMPT 'Ingrese el ID del pais: ';

begin
    agregar_organizador(&concursoid, '&i_nombre', '&i_desc', &i_pais);
end;
/

SET VERIFY ON;
