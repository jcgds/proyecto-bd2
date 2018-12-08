SET SERVEROUTPUT ON;
SET VERIFY OFF;

 SET FEEDBACK OFF;
    BEGIN
        DBMS_OUTPUT.PUT_LINE(' --- Datos para creacion de concurso ---');
    END;
    /
    SET FEEDBACK ON;
    
ACCEPT c_nombre PROMPT 'Ingrese el nombre del concurso: ';
ACCEPT c_tipoDeCata PROMPT 'Ingrese el tipo de cata: ';
ACCEPT c_deCatadores PROMPT 'El concurso es de catadores? (S/N): ';
ACCEPT c_caracteristicas PROMPT 'Ingrese las caracteristicas del concurso: ';

-- Datos para atributo datosDeContacto
    ACCEPT c_dc_telefono1 PROMPT 'Ingrese un telefono de contacto: ';
    ACCEPT c_dc_fax PROMPT 'Ingrese el numero de fax: ';
    ACCEPT c_dc_email PROMPT 'Introduzca el email del concurso: ';
    ACCEPT c_dc_dirWeb PROMPT 'Introduzca la direccion web del concurso: ';

    -- Datos para direccion
    -- TODO: Pedirlos

    -- Datos para persona de contacto
    SET FEEDBACK OFF;
    BEGIN
        DBMS_OUTPUT.PUT_LINE(' --- Datos para creacion de persona de contacto ---');
    END;
    /
    SET FEEDBACK ON;
    
    ACCEPT c_dc_persona_nombre PROMPT 'Ingrese el nombre de la persona de contacto: ';
    ACCEPT c_dc_persona_apellido PROMPT 'Ingrese el apellido de la persona de contacto: ';
    ACCEPT c_dc_persona_cargo PROMPT 'Ingrese el cargo de la persona de contacto: ';
    ACCEPT c_dc_persona_email PROMPT 'Ingrese el email de la persona de contacto: ';


create or replace procedure crear_concurso as
    c_nombre varchar2(50) := '&c_nombre';
    c_tipoDeCata varchar2(50) := '&c_tipoDeCata';
    c_deCatadores varchar2(50) := '&c_deCatadores';
    c_caracteristicas varchar2(50) := '&c_caracteristicas';
    c_dc_telefono1 NUMBER := &c_dc_telefono1;
    c_dc_fax NUMBER := &c_dc_fax;
    c_dc_email varchar2(50) := '&c_dc_email';
    c_dc_dirWeb varchar2(50) := '&c_dc_dirWeb';
    c_dc_persona_nombre varchar2(50) := '&c_dc_persona_nombre';
    c_dc_persona_apellido varchar2(50) := '&c_dc_persona_apellido';
    c_dc_persona_cargo varchar2(50) := '&c_dc_persona_cargo';
    c_dc_persona_email varchar2(50) := '&c_dc_persona_email';
begin
    DBMS_OUTPUT.PUT_LINE('Leido: ' || TO_CHAR(c_dc_telefono1));
end;
/
SET VERIFY ON;
execute crear_concurso();