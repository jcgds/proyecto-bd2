SET SERVEROUTPUT ON;
SET VERIFY OFF;

ACCEPT idMarca PROMPT 'Ingrese el id de la marca de vino: ';
ACCEPT idPresentacion PROMPT 'Ingrese el id de la presentacion: ';
ACCEPT anio PROMPT 'Ingrese el anio: ';
ACCEPT precio PROMPT 'Ingrese el precio de la presentacion: ';

begin
  crear_precio_presentacion (
      &idMarca,
      &idPresentacion,
      &anio,
      &precio
  );
end;
/

SET VERIFY ON;