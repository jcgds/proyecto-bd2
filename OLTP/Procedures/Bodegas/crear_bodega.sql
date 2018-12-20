SET SERVEROUTPUT ON;
SET VERIFY OFF;

ACCEPT nombre PROMPT 'Ingrese el nombre de la bodega: ';
ACCEPT fechaFundacion PROMPT 'Ingrese la fecha de fundacion (Dia-Mes-Anio): ';
ACCEPT descripcionMision PROMPT 'Ingrese la descripcion de la mision: ';
ACCEPT descripcionGeneralVinos PROMPT 'Ingrese la descripcion general de vinos: ';
ACCEPT propietario PROMPT 'Ingrese el id de la bodega propietaria (null si no tiene): ';

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

begin

    insertar_bodega(
        '&nombre',
        to_date('&fechaFundacion', 'DD-MM-YYYY'),
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
        '&descripcionMision',
        '&descripcionGeneralVinos',
        &propietario
    );

    DBMS_OUTPUT.PUT_LINE('Para crear una nueva denominacion de origen ejecute @Procedures/DO/crear_do');
    DBMS_OUTPUT.PUT_LINE('Para crear una nueva marca de vino ejecute @Procedures/Marcas/crear_marca');
end;
/

SET VERIFY ON;
