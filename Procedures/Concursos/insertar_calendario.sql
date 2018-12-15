SET SERVEROUTPUT ON;
SET VERIFY OFF;

ACCEPT concursoid PROMPT 'Ingrese el id del concurso: ';

-- Datos Bancarios
    SET FEEDBACK OFF;
    BEGIN
        DBMS_OUTPUT.PUT_LINE(' --- Datos bancarios ---');
    END;
    /
    ACCEPT recipiente PROMPT 'Ingrese el recipiente: ';
    ACCEPT nombreBanco PROMPT 'Ingrese el nombre del banco: ';
    ACCEPT codigoCuenta PROMPT 'Ingrese el codigo de cuenta: ';
    ACCEPT codigoSucursal PROMPT 'Ingrese el codigo de sucursal bancaria: ';

ACCEPT limiteEnvioInsc PROMPT 'Ingrese la fecha limite para el envio de inscripcion (Dia-Mes-Anio): ';
ACCEPT limiteRecepcionVinos PROMPT 'Ingrese la fecha limite para la recepcion de vinos (Dia-Mes-Anio): ';
ACCEPT fechaInicio PROMPT 'Ingrese la fecha en la que incia la edicion (Dia-Mes-Anio): ';
ACCEPT fechaFin PROMPT 'Ingrese la fecha en la que termina la edicion (Dia-Mes-Anio): ';

-- Datos para unidad monetaria
    ACCEPT n_unidad_mon PROMPT 'Ingrese el nombre de la unidad monetaria: ';
    ACCEPT n_unidad_simbolo PROMPT 'Ingrese el simbolo de la unidad monetaria: ';

ACCEPT precioStd PROMPT 'Ingrese el precio estandar por muestra: ';

-- Datos para direccion de envio de muestras
    SET FEEDBACK OFF;
    BEGIN
        DBMS_OUTPUT.PUT_LINE(' --- Datos para direccion de envio de muestras ---');
    END;
    /
    SET FEEDBACK ON;
    ACCEPT c_estado PROMPT 'Ingrese el estado: ';
    ACCEPT c_cod_postal PROMPT 'Ingrese el codigo postal: ';
    ACCEPT c_linea1 PROMPT 'Linea de direccion 1: ';
    ACCEPT c_linea2 PROMPT 'Linea de direccion 2: ';

-- Datos para Lugar
    ACCEPT lu_ciudad PROMPT 'Ingrese la ciudad en la que se realizara la edicion: ';
    ACCEPT lu_pais PROMPT 'Ingrese el pais en el que se realizara la edicion: ';

ACCEPT emailInsc PROMPT 'Ingrese el email para envio de inscripcion: ';

-- Datos para atributo datosDeContacto
    ACCEPT dc_telefono1 PROMPT 'Ingrese un telefono de contacto: ';
    ACCEPT dc_fax PROMPT 'Ingrese el numero de fax: ';
    ACCEPT dc_email PROMPT 'Introduzca el email de la edicion: ';
    ACCEPT dc_dirWeb PROMPT 'Introduzca la direccion web de la edicion: ';

    -- Datos para direccion
    SET FEEDBACK OFF;
    BEGIN
        DBMS_OUTPUT.PUT_LINE(' --- Datos para direccion de edicion ---');
    END;
    /
    SET FEEDBACK ON;
    ACCEPT dc_estado PROMPT 'Ingrese el estado: ';
    ACCEPT dc_cod_postal PROMPT 'Ingrese el codigo postal: ';
    ACCEPT dc_linea1 PROMPT 'Linea de direccion 1: ';
    ACCEPT dc_linea2 PROMPT 'Linea de direccion 2: ';    

begin

    insertar_calendario(
        ids_seq.nextval,
        datosBancarios(
            '&recipiente',
            '&nombreBanco',
            '&codigoCuenta',
            '&codigoSucursal'
        ),
        to_date('&limiteEnvioInsc', 'DD-MM-YYYY'),
        to_date('&limiteRecepcionVinos', 'DD-MM-YYYY'),
        to_date('&fechaInicio', 'DD-MM-YYYY'),
        to_date('&fechaFin', 'DD-MM-YYYY'),
        &precioStd,
        direccion(
            '&c_estado',
            '&c_cod_postal',
            '&c_linea1',
            '&c_linea2'
        ),
        lugar(
            '&lu_ciudad',
            '&lu_pais'
        ),
        unidadMonetaria(
            '&n_unidad_mon',
            '&n_unidad_simbolo'
        ),
        '&emailInsc',
        datosDeContacto(
            conj_telefonos(&dc_telefono1),
            &dc_fax,
            '&dc_email',
            '&dc_dirWeb',
            direccion(
                '&dc_estado',
                '&dc_cod_postal',
                '&dc_linea1',
                '&dc_linea2'
            ),
            null
        ),
        &concursoid
    );
end;
/