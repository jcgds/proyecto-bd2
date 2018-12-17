SET SERVEROUTPUT ON;
SET VERIFY OFF;

ACCEPT pasaporte PROMPT 'Ingrese su numero de pasaporte: ';
ACCEPT nombre PROMPT 'Ingrese su nombre: ';
ACCEPT apellido PROMPT 'Ingrese su apellido: ';
ACCEPT fecha PROMPT 'Ingrese su fecha de nacimiento en el formato dia/mes/año : ';
ACCEPT genero PROMPT 'Ingrese su genero, M masculino o F femenino: ';
ACCEPT ciudad PROMPT 'Ingrese su ciudad de nacimiento: ';
ACCEPT pais PROMPT 'Ingrese su pais de nacimiento: ';

begin

    insertar_catador_aprendiz(&pasaporte, &nombre, &apellido, &fecha, &genero, &ciudad, &pais);

end;
/

SET VERIFY ON;
