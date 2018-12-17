SET SERVEROUTPUT ON;
SET VERIFY OFF;

ACCEPT idBodega PROMPT 'Ingrese el id de la bodega a inscribir: ';
ACCEPT idEdicion PROMPT 'Ingrese el id de la edicion a la cual inscribir la bodega: ';

-- TODO: Mezclar con datos de muestra compite, para inscribirse debe colocar todos los datos
--       como en el formulario de inscripcion de las bodegas
begin

    inscribir_bodega(&idBodega, &idEdicion);

end;
/

SET VERIFY ON;
