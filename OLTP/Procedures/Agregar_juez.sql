SET SERVEROUTPUT ON;
SET VERIFY OFF;

ACCEPT idCatador PROMPT 'Ingrese el id del catador experto que actua como juez: ';
ACCEPT idEdicion PROMPT 'Ingrese el id de la edicion de la que es juez: ';

begin

    agregar_juez(&idCatador, &idEdicion);

end;
/

SET VERIFY ON;
