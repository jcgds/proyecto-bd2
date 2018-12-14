SET SERVEROUTPUT ON;
SET VERIFY OFF;

ACCEPT concursoid PROMPT 'Ingrese el id del concurso: ';
ACCEPT p_nombre PROMPT 'Ingrese el nombre del premio: ';
ACCEPT p_posicion PROMPT 'Ingrese la posicion que representa: ';
ACCEPT p_descripcion PROMPT 'Descripcion del premio: ';
ACCEPT p_tipo PROMPT 'Tipo del premio: ';
ACCEPT p_premioMoneda PROMPT 'Premio en moneda: ';

begin
    insertar_premio_a(
        &concursoid,
        '&p_nombre', 
        &p_posicion, 
        '&p_descripcion', 
        '&p_tipo', 
        &p_premioMoneda
    );
end;
/

SET VERIFY ON;
