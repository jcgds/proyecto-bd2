SET SERVEROUTPUT ON;
SET VERIFY OFF;

ACCEPT idMarca PROMPT 'Ingrese el id de la marca de vino a la que pertenece la muestra: ';
ACCEPT anada PROMPT 'Ingrese la añada a la que pertenece la muestra: ';
ACCEPT idCatadorExperto PROMPT 'Ingrese el id del juez que califico la muestra: ';
ACCEPT idEdicion PROMPT 'Ingrese el id la edicion del concurso: ';
ACCEPT sumatoriaExperto PROMPT 'Ingrese el puntaje dado por el experto: ';


begin

    insertar_muestra_catador(&anada, &sumatoriaExperto, &idMarca, &idCatadorExperto, &idEdicion);

end;
/

SET VERIFY ON;
