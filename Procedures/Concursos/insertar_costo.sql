SET SERVEROUTPUT ON;
SET VERIFY OFF;

ACCEPT edicionid PROMPT 'Ingrese el id de la edicion: ';
ACCEPT nroMuestras PROMPT 'Ingrese el numero de muestras: ';
ACCEPT valor PROMPT 'Ingrese el precio: ';
ACCEPT unidadValor PROMPT 'Ingrese la unidad monetaria: '
ACCEPT pais PROMPT 'Ingrese el pais: ';

begin

    insertar_costo_a(&edicionid, &nroMuestras, &valor,'&unidadValor','&pais');

end;
/

SET VERIFY ON;
