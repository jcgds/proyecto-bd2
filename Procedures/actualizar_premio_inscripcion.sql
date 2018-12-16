SET SERVEROUTPUT ON;
SET VERIFY OFF;

ACCEPT idInscripcion PROMPT 'Ingrese el id de la inscripcion a la cual se le agregara el premio: ';
ACCEPT premio PROMPT 'Ingrese el nombre del premio: ';

begin

    actualizar_premio_inscripcion(&idInscripcion, &premio);

end;
/

SET VERIFY ON;
