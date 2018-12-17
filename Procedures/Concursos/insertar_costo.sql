SET SERVEROUTPUT ON;
SET VERIFY OFF;

ACCEPT edicionid PROMPT 'Ingrese el id de la edicion: ';
ACCEPT nroMuestras PROMPT 'Ingrese el numero de muestras: ';
ACCEPT valor PROMPT 'Ingrese el precio: ';
ACCEPT pais PROMPT 'Ingrese el pais: ';

begin
    insertar_costo_a(&edicionid, &nroMuestras, &valor,'&pais');
end;
/

SET VERIFY ON;
