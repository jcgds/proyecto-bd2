SET SERVEROUTPUT ON;
SET VERIFY OFF;

ACCEPT idMarca PROMPT 'Ingrese el id de la marca de vino a la que pertenece la muestra: ';
ACCEPT anada PROMPT 'Ingrese la añada a la que pertenece la muestra: ';
ACCEPT idInscripcion PROMPT 'Ingrese el id de la inscripcion de la muestra: ';

begin

    insertar_muestra_compite(&anada, &idMarca, &idInscripcion);

end;
/

SET VERIFY ON;
