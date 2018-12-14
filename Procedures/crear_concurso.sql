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
    SET FEEDBACK OFF;
    BEGIN
        DBMS_OUTPUT.PUT_LINE(' --- Datos para direccion ---');
    END;
    /
    SET FEEDBACK ON;
    ACCEPT c_estado PROMPT 'Ingrese el estado: ';
    ACCEPT c_cod_postal PROMPT 'Ingrese el codigo postal: ';
    ACCEPT c_linea1 PROMPT 'Linea de direccion 1: ';
    ACCEPT c_linea2 PROMPT 'Linea de direccion 2: ';

    -- Datos para persona de contacto
    SET FEEDBACK OFF;
    BEGIN
        DBMS_OUTPUT.PUT_LINE(' --- Datos para creacion de persona de contacto ---');
    END;
    /
    SET FEEDBACK ON;
    
    ACCEPT c_persona_nombre PROMPT 'Ingrese el nombre de la persona de contacto: ';
    ACCEPT c_persona_apellido PROMPT 'Ingrese el apellido de la persona de contacto: ';
    ACCEPT c_persona_cargo PROMPT 'Ingrese el cargo de la persona de contacto: ';
    ACCEPT c_persona_email PROMPT 'Ingrese el email de la persona de contacto: ';

BEGIN
    WINE_SCHEMA.insertar_concurso(
        '&c_nombre',
        datosDeContacto(
            conj_telefonos(&c_dc_telefono1),
            &c_dc_fax,
            '&c_dc_email',
            '&c_dc_dirWeb',
            direccion(
                '&c_estado',
                '&c_cod_postal',
                '&c_linea1',
                '&c_linea2'
            ),
            personasDeContacto(
                personaDeContacto(
                    '&c_persona_nombre',
                    '&c_persona_apellido',
                    '&c_persona_cargo',
                    '&c_persona_email'
                )
            )
        ),
        '&c_tipoDeCata',
        '&c_deCatadores',
        '&c_caracteristicas'
    );

    DBMS_OUTPUT.PUT_LINE('Para agregar un premio al concurso ejecute: @insertar_premio');
    DBMS_OUTPUT.PUT_LINE('Para agregar una escala al concurso ejecute: @insertar_escala');
END;
/
SET VERIFY ON;
