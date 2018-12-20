SET SERVEROUTPUT ON;
SET VERIFY OFF;

ACCEPT concursoid PROMPT 'Ingrese el id del concurso: ';
ACCEPT i_elemento PROMPT 'Ingrese el elemento: ';
ACCEPT i_rangoInferior PROMPT 'Ingrese el rango inferior: ';
ACCEPT i_rangoSuperior PROMPT 'Ingrese el rango superior: ';
ACCEPT i_clasificacion PROMPT 'Ingrese la clasificacion: ';

begin
    insertar_escala_a(&concursoid, '&i_elemento', &i_rangoInferior, &i_rangoSuperior, '&i_clasificacion');
end;
/

SET VERIFY ON;
