SET SERVEROUTPUT ON;
SET VERIFY OFF;

ACCEPT idCatador PROMPT 'Ingrese el catador que actua como juez: ';
ACCEPT idEdicion PROMPT 'Ingrese la edicion de la que es juez: ';

begin

    agregar_juez(&idCatador, &idEdicion);

end;
/

SET VERIFY ON;
