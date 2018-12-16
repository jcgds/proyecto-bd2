SET SERVEROUTPUT ON;
SET VERIFY OFF;

ACCEPT anada PROMPT 'Ingrese la añada a la que pertenece la muestra: ';
ACCEPT sumatoriaExperto PROMPT 'Ingrese el puntaje dado por el experto: ';
ACCEPT idMarca PROMPT 'Ingrese el id de la marca de vino a la que pertenece la muestra: ';
ACCEPT idCatadorExperto PROMPT 'Ingrese el id del juez que califico la muestra: ';
ACCEPT idEdicion PROMPT 'Ingrese el id del juez que califico la muestra: ';

begin

    insertar_muestra_catador(&anada, &sumatoriaExperto, &idMarca, &idCatadorExperto, &idEdicion);

end;
/

SET VERIFY ON;
