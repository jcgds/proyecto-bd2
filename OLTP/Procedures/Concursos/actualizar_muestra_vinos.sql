SET SERVEROUTPUT ON;
SET VERIFY OFF;

ACCEPT idMuestraC PROMPT 'Ingrese el id de la muestra: ';
ACCEPT idFkInscripcion PROMPT 'Ingrese el id de la inscripcion asociada: ';
ACCEPT nombre PROMPT 'Ingrese el nombre del premio: ';
ACCEPT posicion PROMPT 'Ingrese la posicion: '
ACCEPT descripcion PROMPT 'Ingrese la descripcion: ';
ACCEPT tipo PROMPT 'Ingrese el tipo: ';
ACCEPT premioMoneda PROMPT 'Ingrese el valor monetario: ';

begin

    insertar_premio_a_vino(&idMuestraC, &idFkInscripcion, '&nombre',&posicion,'&descripcion','&tipo',&premioMoneda);

end;
/

SET VERIFY ON;
