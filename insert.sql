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

insert into DenominacionDeOrigen (id, nombre, descripcion, FK_VariedadVid, FK_Region) values 
(1,'DOC Douro', null, 1, 1);

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

insert into B_DO (id, fk_do_id, fk_do_variedadvid, fk_do_region, fk_bodega) values 
(1, 1, 1, 1, 1); -- B_DO Entre bodega Quinta Da Fronteira y la DOC Douro 

insert into MarcaVino_B_DO (id, fk_marcavino, fk_clasificacionvinos, fk_b_do, fk_bodega, fk_denominaciondeorigen, fk_do_variedadvid, fk_do_region) values
(1, 1, 17, 1, 1, 1, 1, 1); -- Quinta Da Fronteira - DOC Douro - Reserva Tinto

-----------------------------------------------------------------------------
insert into Pais values (4, 'Estados Unidos', 'América', tipo_valor_nt(), tipo_valor_nt(tipo_valor(2016,26900000,'hl')), distribucion_exp_nt(), 
    unidadMonetaria('Dolar', 'US'), bfilename('mapas_regionales', 'usa.jpg'), null);
-- Bodega OPUS ONE -----------------------------------------------    
insert into Region values (2, 'Oakville AVA', null, 4);

insert into VariedadVid values (4,'Zinfandel');
insert into VariedadVid values (5,'Gamay');
insert into VariedadVid values (6,'Chemin blanc');

insert into DenominacionDeOrigen values (2,'American Viticultural Area', null, 4, 2);

insert into Bodega values (
    2, 
    'Opus One',
    hechos_hist_nt(hechos_hist(1980, 'Fundacion por Baron Philippe y Robert Mondavi')),
    TO_DATE('12-06-1980', 'DD-MM-YYYY'), 
    DATOSDECONTACTO(
        conj_telefonos(18002926787,17009449442), 
        null, 
        'info@opuswinery.com', 
        'https://es.opusonewinery.com/',
        direccion('Oakville, CA', '94562', '7900 St. Helena Highway', null),
        personasDeContacto(personaDeContacto('John','Cena','Winemaker','johnc@opuswinery.com'))
    ),
    'En Opus One la esencia del tiempo se expresa por el carácter de cada cosecha.' || 
    'El lugar, a menudo definido como "terroir", representa la geografía, el clima y el elemento humano esencial que se captura en el equilibrio 
     del vino entre la fuerza y la finura, la estructura y la textura.',
    'TODO: Tal vez deberia poder ser null (Descripcion general vinos)',
    tipo_valor_nt(),  -- TODO: Conseguir y llenar esta tabla con 3 anios
    distribucion_exp_nt(), -- TODO: Conseguir y llenar esta tabla con 3 anios
    null
);
insert into MarcaVino values (
    2,
    16,
    'Overture',
    'Overture es una expresión atemporal de los viñedos de nuestra finca, con cuerpo pero accesible en su juventud. Overture muestra una abundancia de aromas y sabores de frutas silvestres con un paladar medio suave y sutil.',
    'Deep dark fruits and cherries. Leather, black pepper. Light but long lasting taste of grapes at the end. Paired with garlic roasted lamb rack',
    14,
    'N',
    1.1,
    14,
    tipo_valor_nt(tipo_valor(2011, 26654, 'litros'), tipo_valor(2012, 36225, 'litros'), tipo_valor(2013, 14562, 'litros')),
    distribucion_exp_nt(), -- TODO: Conseguir o inventar datos de exportacion
    calificacion_nt(
        calificacion('Robert Parker Wine Advocate', tipo_valor(2014, 98, 'puntos')),
        calificacion('James Suckling', tipo_valor(2014, 98, 'puntos')),
        calificacion('Wine Spectator', tipo_valor(2014, 93, 'puntos'))
    ),
    18,
    20,
    maridajes('Carnes rojas', 'Asados', 'Quesos de sabor intenso'),
    4.1,
    'Corcho',
    null -- TODO: Ver como se sube un BLOB
);




