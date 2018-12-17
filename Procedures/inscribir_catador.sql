SET SERVEROUTPUT ON;
SET VERIFY OFF;

ACCEPT idCatador PROMPT 'Ingrese el id del catador a inscribir: ';
ACCEPT idEdicion PROMPT 'Ingrese el id de la edicion a la cual inscribir al catador: ';

-- TODO: Pedir datos para registrar CatadorAprendiz, esto es como la ficha de inscripcion a un torneo de
--       catadores

begin

    inscribir_catador(&idCatador, &idEdicion);

end;
/

SET VERIFY ON;
