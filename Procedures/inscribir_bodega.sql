SET SERVEROUTPUT ON;
SET VERIFY OFF;

ACCEPT idBodega PROMPT 'Ingrese el id de la bodega a inscribir: ';
ACCEPT idEdicion PROMPT 'Ingrese el id de la edicion a la cual inscribir la bodega: ';

begin

    inscribir_bodega(&idBodega, &idEdicion);

end;
/

SET VERIFY ON;
