-- Clasificaciones de Vino ------------------------------------------------------------------------------
insert into ClasificacionVinos (id, fk_clasificacionvinos, nombre, nivel, porcentajes) values 
(1, null, 'Tinto', 1, rangoPorcentajeVol(0,0));
insert into ClasificacionVinos (id, fk_clasificacionvinos, nombre, nivel, porcentajes) values 
(2, null, 'Blanco', 1, rangoPorcentajeVol(0,0));

    -- Clasificacion de vinos blancos -------------------------------------------------------------------
    insert into ClasificacionVinos (id, fk_clasificacionvinos, nombre, nivel, porcentajes) values 
    (4, 2, 'Ligeros y Secos', 2, rangoPorcentajeVol(9,12));
    insert into ClasificacionVinos (id, fk_clasificacionvinos, nombre, nivel, porcentajes) values 
    (5, 2, 'Secos y amplios', 2, rangoPorcentajeVol(10,13));
    insert into ClasificacionVinos (id, fk_clasificacionvinos, nombre, nivel, porcentajes) values 
    (6, 2, 'Secos y concentrados', 2, rangoPorcentajeVol(11,14));
    insert into ClasificacionVinos (id, fk_clasificacionvinos, nombre, nivel, porcentajes) values 
    (7, 2, 'Aromaticos', 2, rangoPorcentajeVol(11,13));
    insert into ClasificacionVinos (id, fk_clasificacionvinos, nombre, nivel, porcentajes) values 
    (8, 2, 'Semisecos', 2, rangoPorcentajeVol(6,14));
    insert into ClasificacionVinos (id, fk_clasificacionvinos, nombre, nivel, porcentajes) values 
    (9, 2, 'Dulces y Licorosos', 2, rangoPorcentajeVol(9,18));
    -- Clasificacion de vinos tintos --------------------------------------------------------------------
    insert into ClasificacionVinos (id, fk_clasificacionvinos, nombre, nivel, porcentajes) values 
    (10, 1, 'Rosados', 2, rangoPorcentajeVol(10,14));
    insert into ClasificacionVinos (id, fk_clasificacionvinos, nombre, nivel, porcentajes) values 
    (11, 1, 'Ligeros, afrutados, no envejecidos', 2, rangoPorcentajeVol(10,12));
    insert into ClasificacionVinos (id, fk_clasificacionvinos, nombre, nivel, porcentajes) values 
    (12, 1, 'De cuerpo medio', 2, rangoPorcentajeVol(12,13));
    insert into ClasificacionVinos (id, fk_clasificacionvinos, nombre, nivel, porcentajes) values 
    (13, 1, 'Concentrados, Intensos', 2, rangoPorcentajeVol(12,14));
    insert into ClasificacionVinos (id, fk_clasificacionvinos, nombre, nivel, porcentajes) values 
    (14, 1, 'De Guarda', 2, rangoPorcentajeVol(12, 13));
    insert into ClasificacionVinos (id, fk_clasificacionvinos, nombre, nivel, porcentajes) values 
    (15, 1, 'Especiales', 2, rangoPorcentajeVol(14,17));
        -- Clasificacion tintos especiales -------------------------------------------------------------
        insert into ClasificacionVinos (id, fk_clasificacionvinos, nombre, nivel, porcentajes) values 
        (16, 15, 'Secos', 3, rangoPorcentajeVol(14,17));
        insert into ClasificacionVinos (id, fk_clasificacionvinos, nombre, nivel, porcentajes) values 
        (17, 15, 'Semisecos', 3, rangoPorcentajeVol(14,17));
        insert into ClasificacionVinos (id, fk_clasificacionvinos, nombre, nivel, porcentajes) values 
        (18, 15, 'Dulces', 3, rangoPorcentajeVol(14,17));
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
        direccion('Freixo de Espada � Cinta', '5180-909', 'Apartado 17 - 5180-909 Freixo de Espada � Cinta', null),
        personasDeContacto(personaDeContacto('Jos�','Menezes','Winemaker','douro@companhiadasquintas.pt'))
    ),
    'Created with the purpose of becoming one of the most important players in the Portuguese wine business.' || 
    ' Its strategy is based on the development of high quality estate wines from 250 hectares of own vineyards,' || 
    ' planted in the major Portuguese wine regions. The company aims to achieve sustained growth, with main focus on foreign markets.',
    'TODO: Tal vez deberia poder ser null (Descripcion general vinos)',
    tipo_valor_nt(),  -- TODO: Conseguir y llenar esta tabla con 3 anios
    distribucion_exp_nt(), -- TODO: Conseguir y llenar esta tabla con 3 anios
    null
);

insert into MarcaVino values (
    1,
    17,
    'Quinta Da Fronteira Reserva Tinto',
    'Grapes were handpicked to 16 kg cases and carefully selected at the winery. The fermentation and maceration were made in conical vats and were adapted to each grape variety as well as the malolatic. Tinta Roriz has done the malolactic fermentation in oak barrels; Touriga Franca has done on skins (sulphited and racked directly to barrel);and Touriga Nacional in vats. The wines were racked to the barrels before spring time. They aged for 18 months in French oak barrels (20% new).',
    'Deep ruby colour, with complex aromas of black ripe fruit, spices, mocha, orange blossom and rockrose hints. In the mouth it reveals a good balance between acidity and soft layered tannins. A long-lasting aromatic taste.',
    17,
    'S',
    1.2,
    15,
    tipo_valor_nt(tipo_valor(2011, 15348, 'litros'), tipo_valor(2012, 15348, 'litros'), tipo_valor(2013, 21126, 'litros')),
    distribucion_exp_nt(), -- TODO: Conseguir o inventar datos de exportacion
    calificacion_nt(
        calificacion('Wine Enthusiast Magazine', tipo_valor(2012, 91, 'puntos')),
        calificacion('Wine Enthusiast Magazine', tipo_valor(2011, 92, 'puntos')),
        calificacion('Wine Advocate/Robert Parker', tipo_valor(2011, 90, 'puntos'))
    ),
    18,
    20,
    maridajes('Carnes rojas', 'Asados', 'Quesos de sabor intenso'),
    5.1,
    'Corcho',
    null -- TODO: Ver como se sube un BLOB
);
-----------------------------------------------------------------------------


