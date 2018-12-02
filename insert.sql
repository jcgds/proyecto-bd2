-- Clasificaciones de Vino ------------------------------------------------------------------------------
insert into ClasificacionVinos (id, fk_clasificacionvinos, nombre, nivel, porcentajeVol) values 
(1, null, 'Tinto', 1, 0);
insert into ClasificacionVinos (id, fk_clasificacionvinos, nombre, nivel, porcentajeVol) values 
(2, null, 'Blanco', 1, 0);

    -- Clasificacion de vinos blancos -------------------------------------------------------------------
    insert into ClasificacionVinos (id, fk_clasificacionvinos, nombre, nivel, porcentajeVol) values 
    (4, 2, 'Ligeros y Secos', 2, 12);
    insert into ClasificacionVinos (id, fk_clasificacionvinos, nombre, nivel, porcentajeVol) values 
    (5, 2, 'Secos y amplios', 2, 13);
    insert into ClasificacionVinos (id, fk_clasificacionvinos, nombre, nivel, porcentajeVol) values 
    (6, 2, 'Secos y concentrados', 2, 14);
    insert into ClasificacionVinos (id, fk_clasificacionvinos, nombre, nivel, porcentajeVol) values 
    (7, 2, 'Aromaticos', 2, 13);
    insert into ClasificacionVinos (id, fk_clasificacionvinos, nombre, nivel, porcentajeVol) values 
    (8, 2, 'Semisecos', 2, 13);
    insert into ClasificacionVinos (id, fk_clasificacionvinos, nombre, nivel, porcentajeVol) values 
    (9, 2, 'Dulces y Licorosos', 2, 18);
    -- Clasificacion de vinos tintos --------------------------------------------------------------------
    insert into ClasificacionVinos (id, fk_clasificacionvinos, nombre, nivel, porcentajeVol) values 
    (10, 1, 'Rosados', 2, 14);
    insert into ClasificacionVinos (id, fk_clasificacionvinos, nombre, nivel, porcentajeVol) values 
    (11, 1, 'Ligeros, afrutados, no envejecidos', 2, 12);
    insert into ClasificacionVinos (id, fk_clasificacionvinos, nombre, nivel, porcentajeVol) values 
    (12, 1, 'De cuerpo medio', 2, 13);
    insert into ClasificacionVinos (id, fk_clasificacionvinos, nombre, nivel, porcentajeVol) values 
    (13, 1, 'Concentrados, Intensos', 2, 14);
    insert into ClasificacionVinos (id, fk_clasificacionvinos, nombre, nivel, porcentajeVol) values 
    (14, 1, 'De Guarda', 2, 13);
    insert into ClasificacionVinos (id, fk_clasificacionvinos, nombre, nivel, porcentajeVol) values 
    (15, 1, 'Especiales', 2, 17);
        -- Clasificacion tintos especiales -------------------------------------------------------------
        insert into ClasificacionVinos (id, fk_clasificacionvinos, nombre, nivel, porcentajeVol) values 
        (16, 15, 'Secos', 3, 17);
        insert into ClasificacionVinos (id, fk_clasificacionvinos, nombre, nivel, porcentajeVol) values 
        (17, 15, 'Semisecos', 3, 17);
        insert into ClasificacionVinos (id, fk_clasificacionvinos, nombre, nivel, porcentajeVol) values 
        (18, 15, 'Dulces', 3, 17);
--------------------------------------------------------------------------------------------------------

insert into Pais values (1, 'Portugal', 'Europa', tipo_valor_nt(), tipo_valor_nt(), distribucion_exp_nt(), 
    unidadMonetaria('Euro', 'EUR'), bfilename('mapas_regionales', 'portugal.jpg'), null);

-- Bodega Quinta Da Fronteira -----------------------------------------------
insert into Region values (1, 'Douro', null, 1);
insert into VariedadVid values (1,'Touriga Nacional');
insert into VariedadVid values (2,'Touriga Franca');
insert into VariedadVid values (3,'Tinta Roriz');

insert into DenominacionDeOrigen values (1,'DOC Douro', null, 1, 1);

insert into Bodega values (
    1, 
    'Quinta Da Fronteira',
    hechos_hist_nt(hechos_hist(1880, 'Fundacion por Guerra Junqueiro')),
    TO_DATE('12-04-1880', 'DD-MM-YYYY'), 
    DATOSDECONTACTO(
        conj_telefonos(351279652619), 
        null, 
        'info@companhiadasquintas.pt', 
        'http://companhiadasquintas.com/en/our-estates/quinta-da-fronteira',
        direccion('Freixo de Espada à Cinta', '5180-909', 'Apartado 17 - 5180-909 Freixo de Espada à Cinta', null),
        personasDeContacto(personaDeContacto('José','Menezes','Winemaker','douro@companhiadasquintas.pt'))
    ),
    'Created with the purpose of becoming one of the most important players in the Portuguese wine business.' || 
    ' Its strategy is based on the development of high quality estate wines from 250 hectares of own vineyards,' || 
    ' planted in the major Portuguese wine regions. The company aims to achieve sustained growth, with main focus on foreign markets.',
    'TODO: Tal vez deberia poder ser null (Descripcion general vinos)',
    tipo_valor_nt(),  -- TODO: Conseguir y llenar esta tabla con 3 anios
    distribucion_exp_nt(), -- TODO: Conseguir y llenar esta tabla con 3 anios
    null
);


-----------------------------------------------------------------------------


