-- Clasificaciones de Vino ------------------------------------------------------------------------------
insert into ClasificacionVinos (id, fk_clasificacionvinos, nombre, nivel, porcentajes) values
(1, null, 'Tinto', 1, rangoPorcentajeVol(0,0));
insert into ClasificacionVinos (id, fk_clasificacionvinos, nombre, nivel, porcentajes) values
(2, null, 'Blanco', 1, rangoPorcentajeVol(0,0));
commit;
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
    commit;
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
    commit;
        -- Clasificacion tintos especiales -------------------------------------------------------------
        insert into ClasificacionVinos (id, fk_clasificacionvinos, nombre, nivel, porcentajes) values
        (16, 15, 'Secos', 3, rangoPorcentajeVol(14,17));
        insert into ClasificacionVinos (id, fk_clasificacionvinos, nombre, nivel, porcentajes) values
        (17, 15, 'Semisecos', 3, rangoPorcentajeVol(14,17));
        insert into ClasificacionVinos (id, fk_clasificacionvinos, nombre, nivel, porcentajes) values
        (18, 15, 'Dulces', 3, rangoPorcentajeVol(14,17));
        commit;
--------------------------------------------------------------------------------------------------------

insert into Pais values (
    1, 
    'Portugal', 
    'Europa',
    tipo_valor_nt(
        tipo_valor(2011, 210, 'millones de hectareas'),
        tipo_valor(2012, 231, 'millones de hectareas'),
        tipo_valor(2013, 224, 'millones de hectareas'),
        tipo_valor(2014, 219, 'millones de hectareas'),
        tipo_valor(2015, 199, 'millones de hectareas'),
        tipo_valor(2016, 190, 'millones de hectareas'),
        tipo_valor(2017, 199, 'millones de hectareas'),
        tipo_valor(2018, 212, 'millones de hectareas')
    ), 
    tipo_valor_nt(), 
    distribucion_exp_nt(), 
    unidadMonetaria('Euro', 'EUR'), 
    bfilename('mapas_regionales', 'portugal.png'), 
    null
);

-- Bodega Quinta Da Fronteira -----------------------------------------------
insert into Region values (1, 'Douro', null, 1);
insert into VariedadVid values (1,'Touriga Nacional');
insert into DenominacionDeOrigen (id, nombre, descripcion, FK_VariedadVid, FK_Region) values
(1,'Douro - Touriga Nacional', null, 1, 1);

insert into VariedadVid values (2,'Touriga Franca');
insert into DenominacionDeOrigen (id, nombre, descripcion, FK_VariedadVid, FK_Region) values
(2,'Douro - Touriga Franca', null, 2, 1);

insert into VariedadVid values (5,'Tinta Roriz');
insert into DenominacionDeOrigen (id, nombre, descripcion, FK_VariedadVid, FK_Region) values
(3,'Douro - Tinta Roriz', null, 5, 1);

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
        direccion('Freixo de Espada é Cinta', '5180-909', 'Apartado 17 - 5180-909 Freixo de Espada é Cinta', null),
        personasDeContacto(personaDeContacto('José','Menezes','Winemaker','douro@companhiadasquintas.pt'))
    ),
    'Created with the purpose of becoming one of the most important players in the Portuguese wine business.' ||
    ' Its strategy is based on the development of high quality estate wines from 250 hectares of own vineyards,' ||
    ' planted in the major Portuguese wine regions. The company aims to achieve sustained growth, with main focus on foreign markets.',
    'The least fruit-like of all dark fruits. When writers mention cassis, they are often thinking of the seedy and gritty character of actual black currants. Homework assignment: try a black currant and report back.',
    tipo_valor_nt(),
    distribucion_exp_nt(),
    null
);

insert into MarcaVino values (
    1,
    17,
    'Reserva',
    'Grapes were handpicked to 16 kg cases and carefully selected at the winery. The fermentation and maceration were made in conical vats and were adapted to each grape variety as well as the malolatic. Tinta Roriz has done the malolactic fermentation in oak barrels; Touriga Franca has done on skins (sulphited and racked directly to barrel);and Touriga Nacional in vats. The wines were racked to the barrels before spring time. They aged for 18 months in French oak barrels (20% new).',
    'Deep ruby colour, with complex aromas of black ripe fruit, spices, mocha, orange blossom and rockrose hints. In the mouth it reveals a good balance between acidity and soft layered tannins. A long-lasting aromatic taste.',
    17,
    'S',
    1.2,
    15,
    tipo_valor_nt(
        tipo_valor(2011, 15348, 'litros'), 
        tipo_valor(2012, 15500, 'litros'), 
        tipo_valor(2013, 21126, 'litros')
    ),
    distribucion_exp_nt(
        distribucion_exp(tipo_valor(2011, 5116, 'litros'), 'Estados Unidos'),
        distribucion_exp(tipo_valor(2011, 2000, 'litros'), 'Venezuela'),
        distribucion_exp(tipo_valor(2012, 6400, 'litros'), 'Alemania'),
        distribucion_exp(tipo_valor(2012, 3200, 'litros'), 'Estados Unidos'),
        distribucion_exp(tipo_valor(2013, 11200, 'litros'), 'Alemania'),
        distribucion_exp(tipo_valor(2013, 7200, 'litros'), 'Estados Unidos')
    ),
    calificacion_nt(
        calificacion('Wine Enthusiast Magazine', tipo_valor(2012, 91, 'puntos')),
        calificacion('Wine Enthusiast Magazine', tipo_valor(2011, 92, 'puntos')),
        calificacion('Wine Advocate/Robert Parker', tipo_valor(2011, 90, 'puntos'))
    ),
    6,
    24,
    maridajes('Carnes rojas', 'Asados', 'Quesos de sabor intenso'),
    5.1,
    'Corcho',
    EMPTY_BLOB()
);

insert into Presentacion values (1, 1, 17, 'Botella', null);
insert into HistoricoPrecio values (2016, 1, 1, 17, 25);
insert into HistoricoPrecio values (2017, 1, 1, 17, 34);
insert into HistoricoPrecio values (2018, 1, 1, 17, 18);

insert into Presentacion values (2, 1, 17, 'Caja', 6);
insert into HistoricoPrecio values (2016, 2, 1, 17, 139.99);
insert into HistoricoPrecio values (2017, 2, 1, 17, 195.99);
insert into HistoricoPrecio values (2018, 2, 1, 17, 99.99);

-- B_DO Entre bodega Quinta Da Fronteira y la Douro Touriga Nacional
insert into B_DO (id, fk_do_id, fk_do_variedadvid, fk_do_region, fk_bodega) values
(1, 1, 1, 1, 1);

insert into Cosecha values (1, 2016, 'E', 1, 1, 1, 1, 1);
insert into Cosecha values (2, 2017, 'MB', 1, 1, 1, 1, 1);
insert into Cosecha values (3, 2018, 'E', 1, 1, 1, 1, 1);

-- B_DO Entre bodega Quinta Da Fronteira y la Douro Touriga Franca
insert into B_DO (id, fk_do_id, fk_do_variedadvid, fk_do_region, fk_bodega) values
(2, 2, 2, 1, 1);

insert into Cosecha values (4, 2016, 'E', 2, 2, 2, 1, 1);
insert into Cosecha values (5, 2017, 'MB', 2, 2, 2, 1, 1);
insert into Cosecha values (6, 2018, 'E', 2, 2, 2, 1, 1);

-- B_DO Entre bodega Quinta Da Fronteira y la Douro Tinta Roriz
insert into B_DO (id, fk_do_id, fk_do_variedadvid, fk_do_region, fk_bodega) values
(3, 3, 5, 1, 1);

insert into Cosecha values (7, 2016, 'E', 3, 3, 5, 1, 1);
insert into Cosecha values (8, 2017, 'MB', 3, 3, 5, 1, 1);
insert into Cosecha values (9, 2018, 'E', 3, 3, 5, 1, 1);

-- Quinta Da Fronteira - Douro Touriga Nacional - Reserva Tinto
insert into MarcaVino_B_DO (id, fk_marcavino, fk_clasificacionvinos, fk_b_do, fk_bodega, fk_denominaciondeorigen, fk_do_variedadvid, fk_do_region) values
(1, 1, 17, 1, 1, 1, 1, 1);

-- Quinta Da Fronteira - Douro Touriga Franca - Reserva Tinto
insert into MarcaVino_B_DO (id, fk_marcavino, fk_clasificacionvinos, fk_b_do, fk_bodega, fk_denominaciondeorigen, fk_do_variedadvid, fk_do_region) values
(2, 1, 17, 2, 1, 2, 2, 1);

-- Quinta Da Fronteira - Douro Tinta Roriz - Reserva Tinto
insert into MarcaVino_B_DO (id, fk_marcavino, fk_clasificacionvinos, fk_b_do, fk_bodega, fk_denominaciondeorigen, fk_do_variedadvid, fk_do_region) values
(3, 1, 17, 3, 1, 3, 5, 1);

insert into VariedadVid values (3,'Viosinho');
insert into DenominacionDeOrigen (id, nombre, descripcion, FK_VariedadVid, FK_Region) values
(4,'Douro - Viosinho', null, 3, 1);

-- B_DO Entre bodega Quinta Da Fronteira y la Douro Viosinho
insert into B_DO (id, fk_do_id, fk_do_variedadvid, fk_do_region, fk_bodega) values
(4, 4, 3, 1, 1);

insert into Cosecha values (10, 2016, 'MB', 4, 4, 3, 1, 1);
insert into Cosecha values (11, 2017, 'MB', 4, 4, 3, 1, 1);
insert into Cosecha values (12, 2018, 'MB', 4, 4, 3, 1, 1);

insert into VariedadVid values (4,'Codega do Lorinho');
insert into DenominacionDeOrigen (id, nombre, descripcion, FK_VariedadVid, FK_Region) values
(5,'Douro - Codega do Lorinho', null, 4, 1);

-- B_DO Entre bodega Quinta Da Fronteira y la Douro Codega do Lorinho
insert into B_DO (id, fk_do_id, fk_do_variedadvid, fk_do_region, fk_bodega) values
(5, 5, 4, 1, 1);

insert into Cosecha values (13, 2016, 'E', 5, 5, 4, 1, 1);
insert into Cosecha values (14, 2017, 'E', 5, 5, 4, 1, 1);
insert into Cosecha values (15, 2018, 'E', 5, 5, 4, 1, 1);

insert into MarcaVino values (
    3,
    9,
    'Fronteira White',
    'Grapes were handpicked to small 16 kg boxes. A soft pressing was followed by a cold settling of the must, which, after reaching the required purity, was fermented for 4 weeks in stainless steel vats at a controlled temperature of 14 -16°C. The wine aged 5 months on fine lees in stainless steel vats which improved its complexity.',
    'Bright citrus coloured wine with lush aroma displaying hints of white fruit (peach) and tropical (pineapple), with some mineral notes typical of the Douro region. On the palate it shows great balance, lively acidity and a lingering after taste.',
    11,
    'N',
    3,
    12.5,
    tipo_valor_nt(
        tipo_valor(2011, 58500, 'litros'),
        tipo_valor(2012, 63500, 'litros'),
        tipo_valor(2013, 67500, 'litros')
    ),
    distribucion_exp_nt(
        distribucion_exp(tipo_valor(2011, 25500, 'litros'), 'Canada'),
        distribucion_exp(tipo_valor(2011, 9800, 'litros'), 'Chile'),
        distribucion_exp(tipo_valor(2012, 30000, 'litros'), 'Canada'),
        distribucion_exp(tipo_valor(2012, 20000, 'litros'), 'Chile'),
        distribucion_exp(tipo_valor(2013, 35000, 'litros'), 'Canada'),
        distribucion_exp(tipo_valor(2013, 15000, 'litros'), 'Chile')
    ),
    calificacion_nt(
        calificacion('Wine Enthusiast Magazine', tipo_valor(2015, 88, 'puntos'))
    ),
    5,
    8,
    maridajes('Pescados', 'Ensaladas', 'Pastas', 'Carnes blancas'),
    6.75,
    'Corcho 1+1',
    EMPTY_BLOB()
);

insert into Presentacion values (3, 3, 9, 'Botella', null);
insert into HistoricoPrecio values (2016, 3, 3, 9, 10);
insert into HistoricoPrecio values (2017, 3, 3, 9, 12);
insert into HistoricoPrecio values (2018, 3, 3, 9, 13);

insert into Presentacion values (4, 3, 9, 'Caja', 6);
insert into HistoricoPrecio values (2016, 4, 3, 9, 55.2);
insert into HistoricoPrecio values (2017, 4, 3, 9, 67.35);
insert into HistoricoPrecio values (2018, 4, 3, 9, 73.5);

-- Quinta Da Fronteira - Douro Viosinho - Fronteira White
insert into MarcaVino_B_DO (id, fk_marcavino, fk_clasificacionvinos, fk_b_do, fk_bodega, fk_denominaciondeorigen, fk_do_variedadvid, fk_do_region) values
(4, 3, 9, 4, 1, 4, 3, 1);

-- Quinta Da Fronteira - Douro Codega do Lorinho - Fronteira White
insert into MarcaVino_B_DO (id, fk_marcavino, fk_clasificacionvinos, fk_b_do, fk_bodega, fk_denominaciondeorigen, fk_do_variedadvid, fk_do_region) values
(5, 3, 9, 5, 1, 5, 4, 1);
-- / Fin Bodega Quinta Da Fronteira ------------------------------------------------------------------------------------------------------------------------

-- Bodega Herdade Da Farizoa --------------------------------------------------------------------------------------------------------------------
insert into Region values (3, 'Alentejo', null, 1);
insert into VariedadVid values (6, 'Aragonez');

insert into DenominacionDeOrigen (id, nombre, descripcion, FK_VariedadVid, FK_Region) values
(6,'IG Alentejano - Touriga Nacional', null, 1, 3);
insert into DenominacionDeOrigen (id, nombre, descripcion, FK_VariedadVid, FK_Region) values
(7,'IG Alentejano - Aragonez', null, 6, 3);

insert into Bodega values (
    3,
    'Herdade Da Farizoa',
    hechos_hist_nt(hechos_hist(1958, 'Fundacionn de la bodega')),
    TO_DATE('22-06-1958', 'DD-MM-YYYY'),
    DATOSDECONTACTO(
        conj_telefonos(351268657552),
        null,
        'info@companhiadasquintas.pt',
        'http://companhiadasquintas.com/en/our-estates/herdade-da-farizoa',
        direccion('Alentejo', '7350-491', 'Herdade da Farizoa - 7350- 491 Terrugem - Elvas', null),
        personasDeContacto(personaDeContacto('Joaquim','Mendes','Winemaker','farizoa@companhiadasquintas.pt'))
    ),
    'Created with the purpose of becoming one of the most important players in the Portuguese wine business.' || 
    ' Its strategy is based on the development of high quality estate wines from 250 hectares of own vineyards,' || 
    ' planted in the major Portuguese wine regions. The company aims to achieve sustained growth, with main focus on foreign markets.',
    'TODO: Tal vez deberia poder ser null (Descripcion general vinos)',
    tipo_valor_nt(),
    distribucion_exp_nt(),
    null
);

-- B_DO Entre bodega Herdade Da Farizoa y la IG Alentejano Touriga Nacional
insert into B_DO (id, fk_do_id, fk_do_variedadvid, fk_do_region, fk_bodega) values
(6, 6, 1, 3, 3);

insert into Cosecha values (16, 2016, 'MB', 6, 6, 1, 3, 3);
insert into Cosecha values (17, 2017, 'MB', 6, 6, 1, 3, 3);
insert into Cosecha values (18, 2018, 'E', 6, 6, 1, 3, 3);

-- B_DO Entre bodega Herdade Da Farizoa y la IG Alentejano Aragonez
insert into B_DO (id, fk_do_id, fk_do_variedadvid, fk_do_region, fk_bodega) values
(7, 7, 6, 3, 3);

insert into Cosecha values (19, 2016, 'E', 7, 7, 6, 3, 3);
insert into Cosecha values (20, 2017, 'E', 7, 7, 6, 3, 3);
insert into Cosecha values (21, 2018, 'E', 7, 7, 6, 3, 3);

insert into MarcaVino values (
    4,
    13,
    'Portas Da Herdade Reserva',
    'Grapes were de-stemmed without crushing, followed by 3 days cold maceration. Fermentation was done at 24 � C with one daily riddle. Malolactic fermentation was done in vats. The final blend aged in French oak barrels for 9 months.',
    'Intense ruby colour and complex aromas with outstanding notes of violet, cherry and chocolate. In the mouth it is full and elegant, with good structure and concentration. Long after-taste confirming its aromatic notes.',
    16,
    'S',
    0.3,
    13.5,
    tipo_valor_nt(
        tipo_valor(2011, 26500, 'litros'), 
        tipo_valor(2012, 34250, 'litros'), 
        tipo_valor(2013, 30750, 'litros')
    ),
    distribucion_exp_nt(
        distribucion_exp(tipo_valor(2011, 6400, 'litros'), 'Alemania'),
        distribucion_exp(tipo_valor(2011, 3600, 'litros'), 'Suecia'),
        distribucion_exp(tipo_valor(2012, 18350, 'litros'), 'Suecia'),
        distribucion_exp(tipo_valor(2012, 6000, 'litros'), 'Brasil'),
        distribucion_exp(tipo_valor(2013, 15000, 'litros'), 'Suecia'),
        distribucion_exp(tipo_valor(2013, 3500, 'litros'), 'Colombia')
    ),
    calificacion_nt(),
    9,
    10,
    maridajes('Carnes ahumadas', 'Pastas', 'Quesos surtidos'),
    5.2,
    'Natural',
    EMPTY_BLOB()
);

-- Herdade Da Farizoa - IG Alentejano Touriga Nacional - Portas Da Herdade Reserva
insert into MarcaVino_B_DO (id, fk_marcavino, fk_clasificacionvinos, fk_b_do, fk_bodega, fk_denominaciondeorigen, fk_do_variedadvid, fk_do_region) values
(6, 4, 13, 6, 3, 6, 1, 3);

-- Herdade Da Farizoa - IG Alentejano Aragonez - Portas Da Herdade Reserva
insert into MarcaVino_B_DO (id, fk_marcavino, fk_clasificacionvinos, fk_b_do, fk_bodega, fk_denominaciondeorigen, fk_do_variedadvid, fk_do_region) values
(7, 4, 13, 7, 3, 7, 6, 3);

---- / Fin Bodega Herdade Da Farizoa ------------------------------------------------------------------------------------------------------------------------------------------

-- Bodega Justino's Madeira --------------------------------------------------------------------------------------------------------------------
insert into Region values (4, 'Madeira', null, 1);
insert into VariedadVid values (7, 'Tinta negra');
insert into DenominacionDeOrigen (id, nombre, descripcion, FK_VariedadVid, FK_Region) values
(8,'Madeira - Tinta negra', null, 7, 4);

insert into Bodega values (
    4,
    'Justino''s Madeira',
    hechos_hist_nt(
        hechos_hist(1870, 'Establecimiento de la bodega'),
        hechos_hist(1953, 'Fundacion como empresa familiar'),
        hechos_hist(1993, 'Asociacion con uno de las mayores asociaciones francesas de bebidas alcoholicas, La Martiniquaise'),
        hechos_hist(1994, 'Inauguracion de una nueva bodega con tecnologia de punta en el Parque Industrial da Cancela'),
        hechos_hist(1995, 'Finalizacion de mudanza de la ubicacion inicial en el centro de Funchal al Parque Industrial da Cancela')
    ),
    TO_DATE('10-02-1870', 'DD-MM-YYYY'),
    DATOSDECONTACTO(
        conj_telefonos(351291934257),
        351291934049,
        'justinos@justinosmadeira.com',
        'http://www.justinosmadeira.com',
        direccion('Madeira', '9125-042', 'Parque Industrial da Cancela', 'Canico, Madeira'),
        personasDeContacto()
    ),
    'Durante toda a sua historia a Justino''s Madeira tem vindo, gradualmente, a conquistar e a confirmar a sua presena, um pouco por todo o mundo, com especial destaque para a Franca, Alemanha, Inglaterra, Austria, Suiza, Polonia, Benelux, Espanha e Escandinavia, e tambem E.U.A., Canada, Brasil e Japao.',
    'A empresa dispoe actualmente de um dos maiores stocks de vinhos na Ilha da Madeira, constituido por vinhos de elevada qualidade, envelhecidos em cascos de carvalho, que lhe permitem dar resposta as solicitudes dos mercados mais exigentes e selectivos.',
    tipo_valor_nt(),
    distribucion_exp_nt(),
    null
);

-- B_DO Entre bodega Justino's Madeira y la DO Madeira
insert into B_DO (id, fk_do_id, fk_do_variedadvid, fk_do_region, fk_bodega) values
(8, 8, 7, 4, 4);

insert into Cosecha values (22, 2016, 'MB', 8, 8, 7, 4, 4);
insert into Cosecha values (23, 2017, 'E', 8, 8, 7, 4, 4);
insert into Cosecha values (24, 2018, 'MB', 8, 8, 7, 4, 4);

insert into MarcaVino values (
    5,
    18,
    'Colombo Madeira Tinta Negra',
    'Desenga�e total, esmagamento e prensagem. Vinifica��o em bica-aberta. Fermentado totalmente em cuba de a�o inoxid�vel com controlo de temperatura e tempos de remontagem. Interrup��o da fermenta��o pela adi��o de �lcool v�nico 96�. Adi��o de �lcool v�nico feita ap�s 2 - 3 dias de fermenta��o de forma a manter a quantidade de a��cares desejada. Vinifica��o feita de acordo com os m�todos tradicionais.',
    'Atrativa e brilhante cor �mbar medianamente carregada. Elegante e complexo aroma, rico e com notas de mela�o, bolo de mel, caramelo, noz e mel quente. Elegante em boca, intenso com pronunciadas notas de caramelo de fruta.',
    19,
    'S',
    121.3,
    19,
    tipo_valor_nt(
        tipo_valor(2011, 87500, 'litros'), 
        tipo_valor(2012, 120300, 'litros'), 
        tipo_valor(2013, 210000, 'litros')
    ),
    distribucion_exp_nt(
        distribucion_exp(tipo_valor(2011, 38000, 'litros'), 'Italia'),
        distribucion_exp(tipo_valor(2011, 24500, 'litros'), 'Japon'),
        distribucion_exp(tipo_valor(2012, 60350, 'litros'), 'China'),
        distribucion_exp(tipo_valor(2012, 24250, 'litros'), 'Japon'),
        distribucion_exp(tipo_valor(2013, 65000, 'litros'), 'Japon'),
        distribucion_exp(tipo_valor(2013, 65000, 'litros'), 'China')
    ),
    calificacion_nt(),
    4,
    5,
    maridajes('Fruta tropical', 'Chocolate negro', 'Tortas de frutas', 'Cafe'),
    5.45,
    'Natural',
    EMPTY_BLOB()
);

-- Justino's Madeira - DO Madeira Tinta Negra - Colombo Madeira Tinta Negra
insert into MarcaVino_B_DO (id, fk_marcavino, fk_clasificacionvinos, fk_b_do, fk_bodega, fk_denominaciondeorigen, fk_do_variedadvid, fk_do_region) values
(8, 5, 18, 8, 4, 8, 7, 4);


---- / Fin Bodega Justino's Madeira ------------------------------------------------------------------------------------------------------------------------------------------


insert into Pais values (4, 'Estados Unidos', 'America', tipo_valor_nt(), tipo_valor_nt(), distribucion_exp_nt(), 
    unidadMonetaria('Dolar', 'USD'), bfilename('mapas_regionales', 'usa.jpg'), null);
-- Bodega OPUS ONE -----------------------------------------------
insert into Region values (41, 'Oakville AVA', null, 4);

insert into VariedadVid values (51,'Zinfandel');
insert into DenominacionDeOrigen values (51,'American Viticultural Area Zinfandel', null, 51, 41);
insert into VariedadVid values (52,'Gamay');
insert into DenominacionDeOrigen values (52,'American Viticultural Area Gamay', null, 52, 41);
insert into VariedadVid values (53,'Chemin blanc');
insert into DenominacionDeOrigen values (53,'American Viticultural Area Chemin Blanc', null, 53, 41);

insert into Bodega values (
    51,
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
    'En Opus One la esencia del tiempo se expresa por el car�cter de cada cosecha.' ||
    'El lugar, a menudo definido como "terroir", representa la geograf�a, el clima y el elemento humano esencial que se captura en el equilibrio
     del vino entre la fuerza y la finura, la estructura y la textura.',
    'TODO: Tal vez deberia poder ser null (Descripcion general vinos)',
    tipo_valor_nt(),  -- TODO: Conseguir y llenar esta tabla con 3 anios
    distribucion_exp_nt(), -- TODO: Conseguir y llenar esta tabla con 3 anios
    null
);
insert into B_DO (id, fk_do_id, fk_do_variedadvid, fk_do_region, fk_bodega) values
(51, 51, 51, 41, 51);
insert into MarcaVino values (
    51,
    16,
    'Overture',
    'Overture es una expresi�n atemporal de los vi�edos de nuestra finca, con cuerpo pero accesible en su juventud. Overture muestra una abundancia de aromas y sabores de frutas silvestres con un paladar medio suave y sutil.',
    'Deep dark fruits and cherries. Leather, black pepper. Light but long lasting taste of grapes at the end. Paired with garlic roasted lamb rack',
    14,
    'N',
    1.1,
    14,
    tipo_valor_nt(tipo_valor(2011, 26654, 'litros'), tipo_valor(2012, 36225, 'litros'), tipo_valor(2013, 14562, 'litros')),
    distribucion_exp_nt(distribucion_exp(tipo_valor(2012,23432,'litros'),'Portugal'),distribucion_exp(tipo_valor(2013,23432,'litros'),'Mexico'),distribucion_exp(tipo_valor(2014,23432,'litros'),'Colombia')), -- TODO: Conseguir o inventar datos de exportacion
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
    EMPTY_BLOB() -- TODO: Ver como se sube un BLOB
);

insert into MarcaVino_B_DO (id, fk_marcavino, fk_clasificacionvinos, fk_b_do, fk_bodega, fk_denominaciondeorigen, fk_do_variedadvid, fk_do_region) values
(51, 51, 16, 51, 51, 51, 51, 41);

insert into Presentacion values (51, 51, 16, 'Botella', null);
insert into HistoricoPrecio values (2016, 51, 51, 16, 200);
insert into HistoricoPrecio values (2017, 51, 51, 16, 210);
insert into HistoricoPrecio values (2018, 51, 51, 16, 195);

---------Bodega Joseph Phelps--------

insert into Region values (42, 'St Helena AVA', null, 4);

insert into VariedadVid values (54,'Merlot');
insert into DenominacionDeOrigen values (54,'American Viticultural Area Merlot', null, 54, 42);
insert into VariedadVid values (55,'Cabernet Sauvignon');
insert into DenominacionDeOrigen values (55,'American Viticultural Area Cabernet', null, 55, 42);
insert into VariedadVid values (56,'Syrah');
insert into DenominacionDeOrigen values (56,'American Viticultural Area Syrah', null, 56, 42);

insert into Bodega values (
    52,
    'Joseph Phelps',
    hechos_hist_nt(hechos_hist(1973, 'Fundacion por Joe Phelps')),
    TO_DATE('12-06-1973', 'DD-MM-YYYY'),
    DATOSDECONTACTO(
        conj_telefonos(8007075789,17009449442),
        null,
        'info@josephphelps.com',
        'https://www.josephphelps.com/',
        direccion('St Helena, CA', '94574', '200 Taplin Rd', null),
        personasDeContacto(personaDeContacto('John','Wick','Winemaker','johnc@josephphelps.com'))
    ),
    'Today all of Joseph Phelps Napa Valley wines, including the flagship Insignia,' ||
    'are made with 100% estate grown grapes. The Home Ranch in St. Helena that Joe fell in love with so many years ago
    features 130 acres of wine grapes, olive orchards, fruit trees, bee hives, and a hillside winery offering incomparable hospitality and panoramic vineyard views.',
    'TODO: Tal vez deberia poder ser null (Descripcion general vinos)',
    tipo_valor_nt(),  -- TODO: Conseguir y llenar esta tabla con 3 anios
    distribucion_exp_nt(), -- TODO: Conseguir y llenar esta tabla con 3 anios
    null
);
insert into B_DO (id, fk_do_id, fk_do_variedadvid, fk_do_region, fk_bodega) values
(52, 54, 54, 42, 52);
insert into B_DO (id, fk_do_id, fk_do_variedadvid, fk_do_region, fk_bodega) values
(53, 55, 55, 42, 52);
insert into B_DO (id, fk_do_id, fk_do_variedadvid, fk_do_region, fk_bodega) values
(54, 56, 56, 42, 52);
insert into MarcaVino values (
    52,
    16,
    'Cabernet Sauvignon',
    'The Cabernet Sauvignon from the 2015 vintage is inky purple in color with aromas of dense blackberry jam, cassis and balsamic followed by a layering complexity throughout the mouthfeel of supple,
    sweet tannins with expressive ripe plum, vanilla and rich black fruit.',
    'Grapes were sorted and cold soaked prior to fermentation. The wine was aged for eighteen months in 40% new oak barrels (65% French, 35% American) and 60% one- to two-year-old French and American oak barrels before bottling. The barrel coopers used included Ermitage, François Frères, Demptos (French and American),
    Canton (American), Barrel Associates (American) and Orion',
    14,
    'N',
    1.1,
    14,
    tipo_valor_nt(tipo_valor(2011, 26654, 'litros'), tipo_valor(2012, 36225, 'litros'), tipo_valor(2013, 14562, 'litros')),
    distribucion_exp_nt(distribucion_exp(tipo_valor(2012,23432,'litros'),'Portugal'),distribucion_exp(tipo_valor(2013,23432,'litros'),'Mexico'),distribucion_exp(tipo_valor(2014,23432,'litros'),'Colombia')), -- TODO: Conseguir o inventar datos de exportacion
    calificacion_nt(
        calificacion('Robert Parker Wine Advocate', tipo_valor(2015, 91, 'puntos')),
        calificacion('Jeb Dunnuck', tipo_valor(2015, 93, 'puntos')),
        calificacion('Wine Spectator', tipo_valor(2015, 92, 'puntos'))
    ),
    18,
    20,
    maridajes('Carnes rojas', 'Asados'),
    3.1,
    'Corcho',
    null -- TODO: Ver como se sube un BLOB
);

insert into MarcaVino_B_DO (id, fk_marcavino, fk_clasificacionvinos, fk_b_do, fk_bodega, fk_denominaciondeorigen, fk_do_variedadvid, fk_do_region) values
(52, 52, 16, 52, 52, 54, 54, 42);

insert into Presentacion values (52, 52, 16, 'Botella', null);
insert into HistoricoPrecio values (2016, 52, 52, 16, 167);
insert into HistoricoPrecio values (2017, 52, 52, 16, 189);
insert into HistoricoPrecio values (2018, 52, 52, 16, 152);

insert into Presentacion values (53, 52, 16, 'Caja', 6);
insert into HistoricoPrecio values (2016, 53, 52, 16, 1005);
insert into HistoricoPrecio values (2017, 53, 52, 16, 1100);
insert into HistoricoPrecio values (2018, 53, 52, 16, 950);

insert into MarcaVino values (
    53,
    16,
    'Insignia',
    'Optimum, even ripening for Insignia designated blocks was achieved by careful vineyard management throughout the growing season. Grapes were held separate during picking, sorting and fermentation.',
    'The 2015 Insignia is densely hued with rich dark fruit, cocoa powder and fragrant dried flower notes. Velvety texture and weight on the palate with layers of juicy black plum, Madagascar vanilla and bergamot.
     Bold, creamy and supple with integrated tannin structure and a lengthy finish.',
    14,
    'N',
    1.1,
    14,
    tipo_valor_nt(tipo_valor(2011, 26654, 'litros'), tipo_valor(2012, 36225, 'litros'), tipo_valor(2013, 14562, 'litros')),
    distribucion_exp_nt(distribucion_exp(tipo_valor(2012,23432,'litros'),'Portugal'),distribucion_exp(tipo_valor(2013,23432,'litros'),'Mexico'),distribucion_exp(tipo_valor(2014,23432,'litros'),'Colombia')),
    calificacion_nt(
        calificacion('Robert Parker Wine Advocate', tipo_valor(2015, 97, 'puntos')),
        calificacion('James Suckling', tipo_valor(2015, 96, 'puntos')),
        calificacion('Connoisseurs Guide to California Wine', tipo_valor(2015, 97, 'puntos'))
    ),
    24,
    19,
    maridajes('Carnes rojas'),
    3.1,
    'Corcho',
    null -- TODO: Ver como se sube un BLOB
);

insert into MarcaVino_B_DO (id, fk_marcavino, fk_clasificacionvinos, fk_b_do, fk_bodega, fk_denominaciondeorigen, fk_do_variedadvid, fk_do_region) values
(53, 53, 16, 53, 52, 55, 55, 42);

insert into Presentacion values (54, 53, 16, 'Botella', null);
insert into HistoricoPrecio values (2016, 54, 53, 16, 110);
insert into HistoricoPrecio values (2017, 54, 53, 16, 112);
insert into HistoricoPrecio values (2018, 54, 53, 16, 113);

insert into Presentacion values (55, 53, 16, 'Caja', 6);
insert into HistoricoPrecio values (2016, 55, 53, 16, 600);
insert into HistoricoPrecio values (2017, 55, 53, 16, 635);
insert into HistoricoPrecio values (2018, 55, 53, 16, 590);

insert into MarcaVino values (
    54,
    4,
    'Delice',
    'One of the few Scheurebe plantings in California, grapes were handpicked and frozen, followed by a partial thawing before a long, gentle pressing. The juice was fermented in stainless steel at a cool temperature to retain the subtle aromatics of this variety.',
    'The 2017 Delice is brimming with ripe pear, fragrant white flowers and chamomile followed by intense layers of peach nectar, lemon meringue and candied pineapple. Nicely textured with bright acidity and a honeyed finish.',
    11,
    'N',
    1.4,
    10,
    tipo_valor_nt(tipo_valor(2011, 22654, 'litros'), tipo_valor(2012, 38225, 'litros'), tipo_valor(2013, 34562, 'litros')),
    distribucion_exp_nt(distribucion_exp(tipo_valor(2012,23432,'litros'),'Portugal'),distribucion_exp(tipo_valor(2013,23432,'litros'),'Mexico'),distribucion_exp(tipo_valor(2014,23432,'litros'),'Colombia')), -- TODO: Conseguir o inventar datos de exportacion
    calificacion_nt(
        calificacion('Robert Parker Wine Advocate', tipo_valor(2015, 90, 'puntos')),
        calificacion('James Suckling', tipo_valor(2015, 91, 'puntos')),
        calificacion('Connoisseurs Guide to California Wine', tipo_valor(2015, 89, 'puntos'))
    ),
    21,
    15,
    maridajes('Dulces','Pescado'),
    2.1,
    'Corcho',
    null -- TODO: Ver como se sube un BLOB
);

insert into MarcaVino_B_DO (id, fk_marcavino, fk_clasificacionvinos, fk_b_do, fk_bodega, fk_denominaciondeorigen, fk_do_variedadvid, fk_do_region) values
(54, 54, 4, 54, 52, 56, 56, 42);

insert into Presentacion values (56, 54, 4, 'Botella', null);
insert into HistoricoPrecio values (2016, 56, 54, 4, 110);
insert into HistoricoPrecio values (2017, 56, 54, 4, 112);
insert into HistoricoPrecio values (2018, 56, 54, 4, 113);

insert into Presentacion values (57, 54, 4, 'Caja', 6);
insert into HistoricoPrecio values (2016, 57, 54, 4, 600);
insert into HistoricoPrecio values (2017, 57, 54, 4, 635);
insert into HistoricoPrecio values (2018, 57, 54, 4, 590);


---------- Bodega Ravenswood----------

insert into Region values (43, 'Carneros Valley', null, 4);

insert into VariedadVid values (57,'Zinfandel');
insert into DenominacionDeOrigen values (57,'American Viticultural Area Zinfandel', null, 57, 43);

insert into Bodega values (
    53,
    'Ravenswood',
    hechos_hist_nt(hechos_hist(1976, 'Fundacion por Joel Peterson ')),
    TO_DATE('12-06-1976', 'DD-MM-YYYY'),
    DATOSDECONTACTO(
        conj_telefonos(7079332332,8665683946),
        null,
        'customerservice@ravenswoodwinery.com',
        'https://www.ravenswoodwinery.com/',
        direccion('Sonoma, CA', '95476', '18701 Gehricke Road', null),
        personasDeContacto(personaDeContacto('Ben','Shapiro','Winemaker','bshapiro@ravenswoodwinery.com'))
    ),
    'The fruit he crushed that night was used for one of two single-vineyard Sonoma County Zins – the first wines to bear Ravenswood’s signature ring of ravens. ' ||
    'Ravenswood’s “No Wimpy Wines�? credo says it all – embrace the bold, abhor the bland.',
    'TODO: Tal vez deberia poder ser null (Descripcion general vinos)',
    tipo_valor_nt(),  -- TODO: Conseguir y llenar esta tabla con 3 anios
    distribucion_exp_nt(), -- TODO: Conseguir y llenar esta tabla con 3 anios
    null
);
insert into B_DO (id, fk_do_id, fk_do_variedadvid, fk_do_region, fk_bodega) values
(55, 57, 57, 43, 53);

insert into MarcaVino values (
    55,
    6,
    'Teldeschi ',
    'One of the few Scheurebe plantings in California, grapes were handpicked and frozen, followed by a partial thawing before a long, gentle pressing. The juice was fermented in stainless steel at a cool temperature to retain the subtle aromatics of this variety.',
    'The powerful aromas of black cherries, coffee, caramel, and vanilla as well as other sweet dark fruit scents, combine to create the classic character of a great Dry Creek Zinfandel. Rich flavors of sweet cherry liqueur, vanilla,
    and smoke lead to a ripe, dense, long, and bright fruit finish. Pairs well with grilled meats, even Teriyaki.',
    13,
    'N',
    1.4,
    11,
    tipo_valor_nt(tipo_valor(2011, 22654, 'litros'), tipo_valor(2012, 38225, 'litros'), tipo_valor(2013, 34562, 'litros')),
    distribucion_exp_nt(distribucion_exp(tipo_valor(2012,23432,'litros'),'Portugal'),distribucion_exp(tipo_valor(2013,23432,'litros'),'Mexico'),distribucion_exp(tipo_valor(2014,23432,'litros'),'Colombia')), -- TODO: Conseguir o inventar datos de exportacion
    calificacion_nt(
        calificacion('Wine and Spirits', tipo_valor(2013, 94, 'puntos')),
        calificacion('Wine Enthusiast', tipo_valor(2011, 90, 'puntos')),
        calificacion('Connoisseurs Guide to California Wine', tipo_valor(2015, 89, 'puntos'))
    ),
    20,
    16,
    maridajes('Carnes','Asados'),
    2.1,
    'Corcho',
    null -- TODO: Ver como se sube un BLOB
);

insert into MarcaVino_B_DO (id, fk_marcavino, fk_clasificacionvinos, fk_b_do, fk_bodega, fk_denominaciondeorigen, fk_do_variedadvid, fk_do_region) values
(55, 55, 6, 55, 53, 57, 57, 43);

insert into Presentacion values (58, 55, 6, 'Botella', null);
insert into HistoricoPrecio values (2016, 58, 55, 6, 110);
insert into HistoricoPrecio values (2017, 58, 55, 6, 112);
insert into HistoricoPrecio values (2018, 58, 55, 6, 113);

insert into Presentacion values (59, 55, 6, 'Caja', 6);
insert into HistoricoPrecio values (2016, 59, 55, 6, 600);
insert into HistoricoPrecio values (2017, 59, 55, 6, 635);
insert into HistoricoPrecio values (2018, 59, 55, 6, 590);

insert into MarcaVino values (
    56,
    7,
    'Icon',
    'Ravenswood’s ICON is a revival of this traditional native Sonoma Mixed Blacks blend produced from old, low-production vineyards planted before Prohibition, and is a tribute to Sonoma County’s incredible ancient vines. ',
    'The 2012 ICON displays alluring blackberry, mulberry, and blueberry with exciting hints of anise and pie spice. Lively and weighty, this wine has wonderful tannins and texture, offering structure and grip without being aggressive.
    Its generous finish is a blend of fruit and spice that carries on long after the wine has left your mouth. ',
    11,
    'S',
    1.4,
    15,
    tipo_valor_nt(tipo_valor(2011, 22654, 'litros'), tipo_valor(2012, 38225, 'litros'), tipo_valor(2013, 34562, 'litros')),
    distribucion_exp_nt(distribucion_exp(tipo_valor(2012,23432,'litros'),'Portugal'),distribucion_exp(tipo_valor(2013,23432,'litros'),'Mexico'),distribucion_exp(tipo_valor(2014,23432,'litros'),'Colombia')), -- TODO: Conseguir o inventar datos de exportacion
    calificacion_nt(
        calificacion('Wine Enthusiast', tipo_valor(2011, 90, 'puntos'))
    ),
    19,
    16,
    maridajes('Ensaldas','Postres'),
    6.1,
    'Corcho',
    null -- TODO: Ver como se sube un BLOB
);

insert into MarcaVino_B_DO (id, fk_marcavino, fk_clasificacionvinos, fk_b_do, fk_bodega, fk_denominaciondeorigen, fk_do_variedadvid, fk_do_region) values
(56, 56, 7, 55, 53, 57, 57, 43);

insert into Presentacion values (60, 56, 7, 'Botella', null);
insert into HistoricoPrecio values (2016, 60, 56, 7, 150);
insert into HistoricoPrecio values (2017, 60, 56, 7, 162);
insert into HistoricoPrecio values (2018, 60, 56, 7, 173);

insert into Presentacion values (61, 56, 7, 'Caja', 6);
insert into HistoricoPrecio values (2016, 61, 56, 7, 800);
insert into HistoricoPrecio values (2017, 61, 56, 7, 835);
insert into HistoricoPrecio values (2018, 61, 56, 7, 890);

---------- Sudafrica ----------------
insert into Pais values (2, 'Sudafrica', 'Africa', tipo_valor_nt(), tipo_valor_nt(), distribucion_exp_nt(),
    unidadMonetaria('Rand Sudafricano', 'R'), bfilename('mapas_regionales', 'sudafrica.jpg'), null);

----------Bodega Crsytallum----------
insert into Region values (44, 'Wlker Bay', null, 2);

insert into VariedadVid values (58,'Pinot Nior');
insert into VariedadVid values (59,'Chardonnay');
insert into VariedadVid values (60,'Sauvignon Blanc');
insert into DenominacionDeOrigen values (58,'Wine of Origin Pinot Nior', null, 58, 44);
insert into DenominacionDeOrigen values (59,'Wine of Origin Chardonnay', null, 59, 44);
insert into DenominacionDeOrigen values (60,'Wine of Origin Sauvignon Blanc', null, 60, 44);

insert into Bodega values (
    54,
    'Crystallum',
    hechos_hist_nt(hechos_hist(2007, 'The company was started in 2007 with 4134 bottles of Sauvignon Blanc produced')),
    TO_DATE('12-06-2007', 'DD-MM-YYYY'),
    DATOSDECONTACTO(
        conj_telefonos(270832355748,4740000787),
        null,
        'customerservice@crystallumwines.com',
        'http://www.crystallumwines.com/',
        direccion('Hermanus', '7200', '2 Harbour Rd', null),
        personasDeContacto(personaDeContacto('David','Nel','Sales','steele.nel@gmail.com'))
    ),
    'Crystallum wines is a small, family run and privately owned winery based in the Walker Bay region of South Africa.',
    null,
    tipo_valor_nt(),  -- TODO: Conseguir y llenar esta tabla con 3 anios
    distribucion_exp_nt(), -- TODO: Conseguir y llenar esta tabla con 3 anios
    null
);
insert into B_DO (id, fk_do_id, fk_do_variedadvid, fk_do_region, fk_bodega) values
(56, 58, 58, 44, 54);
insert into B_DO (id, fk_do_id, fk_do_variedadvid, fk_do_region, fk_bodega) values
(57, 59, 59, 44, 54);
insert into B_DO (id, fk_do_id, fk_do_variedadvid, fk_do_region, fk_bodega) values
(58, 60, 60, 44, 54);

insert into MarcaVino values (
    57,
    13,
    'The Agnes Chardonnay',
    'The Agnes is produced using the traditional method of transferring the whole grape clusters straight from harvesting into the press and running the juice off into a settling tank. The juice is then transferred the next day into 228-litre French oak barrels, 10% new.
    Fermentation occurs naturally in barrel, where it remains for 9 months before bottling. No SO2 or enzymes are added prior to fermentation.',
    'The sixth vintage of The Agnes is concentrated and beautifully balanced. The nose is wonderfully expressive with notes of lime, grapefruit, nectarine and ripe peach.
    The palate is intense and layered with a strong fruit core and lovely fresh acidity.',
    11,
    'S',
    1.9,
    13,
    tipo_valor_nt(tipo_valor(2014, 5733, 'litros'), tipo_valor(2015, 13938, 'litros'), tipo_valor(2016, 13912, 'litros')),
    distribucion_exp_nt(distribucion_exp(tipo_valor(2012,23432,'litros'),'Portugal'),distribucion_exp(tipo_valor(2013,23432,'litros'),'Mexico'),distribucion_exp(tipo_valor(2014,23432,'litros'),'Colombia')), -- TODO: Conseguir o inventar datos de exportacion
    calificacion_nt(
        calificacion('Platters Wine Guide', tipo_valor(2008, 90, 'puntos')),
        calificacion('Platters Wine Guide', tipo_valor(2009, 91, 'puntos')),
        calificacion('Platters Wine Guide', tipo_valor(2010, 88, 'puntos'))
    ),
    9,
    16,
    maridajes('Ensaldas','Postres'),
    5.6,
    'Corcho',
    null -- TODO: Ver como se sube un BLOB
);

insert into MarcaVino_B_DO (id, fk_marcavino, fk_clasificacionvinos, fk_b_do, fk_bodega, fk_denominaciondeorigen, fk_do_variedadvid, fk_do_region) values
(57, 57, 13, 57, 54, 59, 59, 44);

insert into Presentacion values (62, 57, 13, 'Botella', null);
insert into HistoricoPrecio values (2016, 62, 57, 13, 150);
insert into HistoricoPrecio values (2017, 62, 57, 13, 162);
insert into HistoricoPrecio values (2018, 62, 57, 13, 173);

insert into Presentacion values (63, 57, 13, 'Caja', 6);
insert into HistoricoPrecio values (2016, 63, 57, 13, 800);
insert into HistoricoPrecio values (2017, 63, 57, 13, 835);
insert into HistoricoPrecio values (2018, 63, 57, 13, 890);

insert into MarcaVino values (
    58,
    13,
    'Bona Fide',
    'Fermentation occurs spontaneously with no commercial yeasts added. There was a 40% whole bunch component with the rest de-stemmed but left intact as whole berries. T
    otal time on skins was 4 weeks where after the wine spent 11 months in French Oak barriques.',
    'Darker and more intense than any other Crystallum Pinot. The heavy soils create stress for the vines resulting in a wine of great concentration and flavour while maintaining freshness and elegance typical of the Hemel en Aarde area.
     Bright cassis and cherry notes, with spice and a slight smokiness lead to a rich and generous palate with supple fruit and full grippy tannins',
    11,
    'S',
    2.7,
    14,
    tipo_valor_nt(tipo_valor(2013, 2189, 'litros'), tipo_valor(2014, 2136, 'litros'), tipo_valor(2015, 3036, 'litros')),
    distribucion_exp_nt(distribucion_exp(tipo_valor(2012,432,'litros'),'Portugal'),distribucion_exp(tipo_valor(2012,432,'litros'),'Mexico'),distribucion_exp(tipo_valor(2014,332,'litros'),'Colombia')), -- TODO: Conseguir o inventar datos de exportacion
    calificacion_nt(
        calificacion('Wine Advocate', tipo_valor(2012, 93, 'puntos')),
        calificacion('Platters Wine Guide', tipo_valor(2014, 88, 'puntos'))
    ),
    11,
    16,
    maridajes('Ensaldas','Postres'),
    5.5,
    'Corcho',
    null -- TODO: Ver como se sube un BLOB
);

insert into MarcaVino_B_DO (id, fk_marcavino, fk_clasificacionvinos, fk_b_do, fk_bodega, fk_denominaciondeorigen, fk_do_variedadvid, fk_do_region) values
(58, 58, 13, 56, 54, 58, 58, 44);

insert into Presentacion values (64, 58, 13, 'Botella', null);
insert into HistoricoPrecio values (2016, 64, 58, 13, 150);
insert into HistoricoPrecio values (2017, 64, 58, 13, 164);
insert into HistoricoPrecio values (2018, 64, 58, 13, 173);

insert into Presentacion values (65, 58, 13, 'Caja', 6);
insert into HistoricoPrecio values (2016, 65, 58, 13, 800);
insert into HistoricoPrecio values (2017, 65, 58, 13, 835);
insert into HistoricoPrecio values (2018, 65, 58, 13, 890);

insert into MarcaVino values (
    59,
    13,
    'Mabalel',
    'Mabalel 2013 was fermented using only native yeasts and unlike the other Crystallum Cuvees, the fruit was completely de-stemmed. The total time in tank was 28 days with a 14 day post maceration. The wine was then transferred to barrel where it remained for 11 months before bottling.
    Minimal sulphates were used in the making of this wine.',
    'Lighter and more feminine than the other Crystallum Pinot’s.
    Dried petals, violets and bright cherry notes lead to an elegant and refined palate with very fine tannins and a fresh finish.',
    11,
    'S',
    2.5,
    13,
    tipo_valor_nt(tipo_valor(2013, 2112, 'litros'), tipo_valor(2014, 3267, 'litros'), tipo_valor(2015, 4338, 'litros')),
    distribucion_exp_nt(distribucion_exp(tipo_valor(2012,432,'litros'),'Portugal'),distribucion_exp(tipo_valor(2013,432,'litros'),'Mexico'),distribucion_exp(tipo_valor(2014,332,'litros'),'Colombia')), -- TODO: Conseguir o inventar datos de exportacion
    calificacion_nt(
        calificacion('Wine Advocate', tipo_valor(2014, 91, 'puntos')),
        calificacion('TREVE RING', tipo_valor(2015, 92, 'puntos'))
    ),
    8,
    16,
    maridajes('Carnes','Pollos'),
    5.3,
    'Metal',
    null -- TODO: Ver como se sube un BLOB
);

insert into MarcaVino_B_DO (id, fk_marcavino, fk_clasificacionvinos, fk_b_do, fk_bodega, fk_denominaciondeorigen, fk_do_variedadvid, fk_do_region) values
(59, 59, 13, 56, 54, 58, 58, 44);

insert into Presentacion values (65, 59, 13, 'Botella', null);
insert into HistoricoPrecio values (2016, 65, 59, 13, 150);
insert into HistoricoPrecio values (2017, 65, 59, 13, 165);
insert into HistoricoPrecio values (2018, 65, 59, 13, 173);

insert into Presentacion values (66, 59, 13, 'Caja', 6);
insert into HistoricoPrecio values (2016, 66, 59, 13, 800);
insert into HistoricoPrecio values (2017, 66, 59, 13, 835);
insert into HistoricoPrecio values (2018, 66, 59, 13, 890);

  ----------Bodega Sumaridge----------
  insert into Region values (104, 'Hemel-en-Aarde', null, 2);
  insert into VariedadVid values (107,'Hermanaus');
  insert into DenominacionDeOrigen values (107,'Wine of Origin Hermanaus', null, 107, 104);
  insert into Bodega values (
      104,
      'Sumaridge',
      hechos_hist_nt(hechos_hist(2014, 'Sumaridge Estate Wines, proudly owned by the Bellingham Turner family, lies gracefully between two imposing mountain ranges in the Western Cape’s Upper Hemel-en-Aarde Valley - aptly named “Heaven and Earth” - with commanding views stretching to Walker Bay on the Atlantic Ocean. Producing the best wines since 2014')),
      TO_DATE('29-05-2014', 'DD-MM-YYYY'),
      DATOSDECONTACTO(
          conj_telefonos(283121097),
          null,
          'info@sumaridge.co.za',
          'http://www.sumaridge.co.za',
          direccion('Hermanus', '7200', 'Upper Hemel-en-Aarde Valley', null),
          personasDeContacto(personaDeContacto('Holly','Bellingham','Spokesman','holly@bellinghamturner.com'))
      ),
      'We will always do our very best to be of assistance, whether you would like to order a selection of our boutique wines or are planning a visit to the Cellar.',
      null,
      tipo_valor_nt(tipo_valor(2014, 600000, 'litros'), tipo_valor(2015, 660000, 'litros'), tipo_valor(2016, 590000, 'litros')),
      distribucion_exp_nt(distribucion_exp(tipo_valor(2014, 440000, 'litros'), 'Japon'),distribucion_exp(tipo_valor(2015, 360000, 'litros'), 'India'),distribucion_exp(tipo_valor(2016, 250000, 'litros'), 'Alemania') ),
      null
  );
  insert into B_DO (id, fk_do_id, fk_do_variedadvid, fk_do_region, fk_bodega) values
  (107, 107, 107, 104, 104);

  insert into MarcaVino values (
      109,
      2,
      'Tara Rosé',
      'Our Tara Rosé shows a brilliant light colour and a fresh bouquet of strawberry, red apple and candy floss. A carefully crafted wine using early harvested Merlot, Cabernet Franc and Malbec grapes for our cool sea facing sites. The style is elegant and classy on a warm summer’s day. This soft, easy drinking but flavourful wine is ideally served chilled with alfresco fare or simply enjoyed in familiar company.',
      'Brilliant wine, bright red that leaves a great after taste.',
      15,
      'S',
      2.4,
      13.2,
      tipo_valor_nt(tipo_valor(2013, 5000, 'litros'), tipo_valor(2014, 4800, 'litros'), tipo_valor(2015, 4950, 'litros')),
      distribucion_exp_nt(distribucion_exp(tipo_valor(2012,789,'litros'),'Portugal'),distribucion_exp(tipo_valor(2013,856,'litros'),'India'),distribucion_exp(tipo_valor(2014,684,'litros'),'Canada')), -- TODO: Conseguir o inventar datos de exportacion
      calificacion_nt(
          calificacion('ProWein', tipo_valor(2015, 85, 'puntos')),
          calificacion('ProWein', tipo_valor(2016, 84, 'puntos'))
      ),
      28,
      12,
      maridajes('Carnes'),
      3.21,
      'Corcho',
      null
  );

  insert into MarcaVino_B_DO (id, fk_marcavino, fk_clasificacionvinos, fk_b_do, fk_bodega, fk_denominaciondeorigen, fk_do_variedadvid, fk_do_region) values
  (109, 109, 2, 107, 104, 107, 107, 104);

  insert into Presentacion values (116, 109, 2, 'Botella', null);
  insert into HistoricoPrecio values (2016, 116, 109, 2, 110);
  insert into HistoricoPrecio values (2017, 116, 109, 2, 112);
  insert into HistoricoPrecio values (2018, 116, 109, 2, 120);

  insert into Presentacion values (117, 109, 2, 'Caja', 6);
  insert into HistoricoPrecio values (2016, 117, 109, 2, 850);
  insert into HistoricoPrecio values (2017, 117, 109, 2, 860);
  insert into HistoricoPrecio values (2018, 117, 109, 2, 880);



-- Concurso de prueba
INSERT INTO Concurso VALUES (
    1,
    'Bacchus',
    DATOSDECONTACTO(
        conj_telefonos(34914293477, 34914291238), 
        null, 
        'info@uec.es', 
        'http://www.concursobacchus.com/',
        direccion('Madrid', '28014', 'C/ Lope de Vega, 27, Madrid, España', null),
        null
    ),
    'A ciegas',
    'N',
    premio_nt(
        premio('Gran Bacchus de oro', 1, null, 'Medalla', null),     
        premio('Bacchus de oro', 2, null, 'Medalla', null),
        premio('Bacchus de plata', 3, null, 'Medalla', null)
    ),
    escala_nt(
        escala('Fase visual', 0, 9, null),      
        escala('Fase olfativa', 0, 18, 'Intensidad'),
        escala('Fase olfativa', 0, 18, 'Calidad'),
        escala('Fase gustativa', 0, 18, 'Intensidad'),
        escala('Fase gustativa', 0, 27, 'Calidad'),
        escala('Armonia', 0, 27, null)
    ),
    'La práctica totalidad del atlas vinícola escoge a Bacchus como escaparate inmejorable de sus elaboraciones. Los cinco continentes vinícolas: Europa, América, África, Asia y Oceanía cuentan año tras año con numerosos representantes en este encuentro global en el que se convierte Bacchus. Una prueba más del prestigio y repercusión que alcanza a nivel internacional la gran cita española con el mundo del vino.'
);

insert into Pais values (
    10,
    'Espana',
    'Europa',
    tipo_valor_nt(),
    tipo_valor_nt(),
    distribucion_exp_nt(),
    unidadMonetaria('Euro', 'EUR'),
    bfilename('mapas_regionales', 'espana.jpg'),
    null
);

INSERT INTO Organizador VALUES
(1, 'Union espanola de catadores', null);

INSERT INTO Organizador VALUES
(2, 'VINOFED',  'Federacion de los concursos internacionales del vino');

INSERT INTO Organizador VALUES
(3, 'OIV', 'Organizacion internacional del vino');

INSERT INTO Organizador VALUES
(4, 'Ministerio de agricultura espanol', null);

commit;

INSERT INTO P_O VALUES
(1, 1, 10);

INSERT INTO P_O VALUES
(2, 2, 10);

INSERT INTO P_O VALUES
(3, 2, 1);

INSERT INTO P_O VALUES
(4, 2, 2);

INSERT INTO P_O VALUES
(5, 4, 10);

INSERT INTO P_O VALUES
(6, 3, 10);

INSERT INTO P_O VALUES
(7, 3, 1);

INSERT INTO P_O VALUES
(8, 3, 2);

INSERT INTO Organizador_Concurso VALUES
(1, 1, 1);

INSERT INTO Organizador_Concurso VALUES
(2, 2, 1);

INSERT INTO Organizador_Concurso VALUES
(3, 3, 1);

INSERT INTO Organizador_Concurso VALUES
(4, 4, 1);

INSERT INTO CatadorExperto VALUES (
    1,
    'Luis',
    'Ramos',
    to_date('09-06-1968', 'DD-MM-YYYY'),
    null,
    hechos_hist_nt(),
    lugar('Lisboa', 'Portugal'),
    publicaciones_nt(
        'Revista de Vinhos - A escolha de Luis Lopes'
    ),
    'M',
    1
);

-------------------Grecia-----------------------------------

insert into Pais values (
    3,
    'Grecia',
    'Europa',
    tipo_valor_nt(), -- superficie vi�edo
    tipo_valor_nt(),
    distribucion_exp_nt(),
    unidadMonetaria('Euro', 'EUR'),
    bfilename('mapas_regionales', 'grecia.jpg'),
    null
);

----------Bodega Seméli----------
  insert into Region values (101, 'Nemea', null, 3);
  insert into VariedadVid values (101,'Agiorgitiko');
  insert into VariedadVid values (102,'Moschofilero');
  insert into VariedadVid values (103,'Roditis');
  insert into DenominacionDeOrigen values (101,'Wine of Origin Agiorgitiko', null, 101, 101);
  insert into DenominacionDeOrigen values (102,'Wine of Origin Moschofilero', null, 102, 101);
  insert into DenominacionDeOrigen values (103,'Wine of Origin Roditis', null, 103, 101);
    insert into Bodega values (
        101,
        'Seméli ',
        hechos_hist_nt(hechos_hist(1979, 'Seméli began in the whine bussiness all the way back in 1979, making their way to leading Greek winery through the offering of best value for money')),
        TO_DATE('06-10-1979', 'DD-MM-YYYY'),
        DATOSDECONTACTO(
            conj_telefonos(306985161414,306985161415),
            null,
            'hospitality@semeliwines.gr',
            'https://www.semeliwines.gr',
            direccion('Athens', '10057', '3 Mitropoleos Street', null),
            personasDeContacto(personaDeContacto('Heracles','The Great','Hero','TheGreatGreekHero@gmail.com'))
        ),
        'The Winery and the private vineyards are located in the heart of Korinthia, the land rich with the history of kings and heroes. A legacy we are bound to fulfill',
        null,
        tipo_valor_nt(tipo_valor(2014, 330000, 'litros'), tipo_valor(2015, 280000, 'litros'), tipo_valor(2016, 270000, 'litros')),
        distribucion_exp_nt(distribucion_exp(tipo_valor(2014, 280000, 'litros'), 'Francia'),distribucion_exp(tipo_valor(2015, 250000, 'litros'), 'Francia'),distribucion_exp(tipo_valor(2016, 220000, 'litros'), 'Francia') ),
        null
    );
    insert into B_DO (id, fk_do_id, fk_do_variedadvid, fk_do_region, fk_bodega) values
    (101, 101, 101, 101, 101);
    insert into B_DO (id, fk_do_id, fk_do_variedadvid, fk_do_region, fk_bodega) values
    (102, 102, 102, 101, 101);
    insert into B_DO (id, fk_do_id, fk_do_variedadvid, fk_do_region, fk_bodega) values
    (103, 103, 103, 101, 101);

    insert into MarcaVino values (
        101,
        1,
        'Nemea Reserve',
        'Produced from Greece’s noblest red grape variety, Agiorgitiko, in our hillside vineyards in Nemea. Matures for 12 months in French oak barrels.',
        'Bright, youthful, deep red color with notable viscosity. Intense on the nose, young, deep in aromas of dense spices, complex fruit and balanced oak. Full-bodied and smooth in the mouth, well balanced with a long aftertaste.',
        15,
        'S',
        2.0,
        13,
        tipo_valor_nt(tipo_valor(2014, 6020, 'litros'), tipo_valor(2015, 8095, 'litros'), tipo_valor(2016, 9056, 'litros')),
        distribucion_exp_nt(distribucion_exp(tipo_valor(2012,8056,'litros'),'Francia'),distribucion_exp(tipo_valor(2013,12300,'litros'),'Australia'),distribucion_exp(tipo_valor(2014,15000,'litros'),'Rusia')),
        calificacion_nt(
            calificacion('The red rose', tipo_valor(2008, 87, 'puntos')),
            calificacion('The red rose', tipo_valor(2009, 90, 'puntos')),
            calificacion('The red rose', tipo_valor(2010, 89, 'puntos'))
        ),
        12,
        16,
        maridajes('Carnes rojas','Pastas'),
        5.8,
        'Corcho',
        null -- TODO: Ver como se sube un BLOB
    );

    insert into MarcaVino_B_DO (id, fk_marcavino, fk_clasificacionvinos, fk_b_do, fk_bodega, fk_denominaciondeorigen, fk_do_variedadvid, fk_do_region) values
    (101, 101, 1, 101, 101, 101, 101, 101);

    insert into Presentacion values (101, 101, 1, 'Botella', null);
    insert into HistoricoPrecio values (2016, 101, 101, 1, 150);
    insert into HistoricoPrecio values (2017, 101, 101, 1, 162);
    insert into HistoricoPrecio values (2018, 101, 101, 1, 173);

    insert into Presentacion values (102, 101, 1, 'Caja', 6);
    insert into HistoricoPrecio values (2016, 102, 101, 1, 800);
    insert into HistoricoPrecio values (2017, 102, 101, 1, 835);
    insert into HistoricoPrecio values (2018, 102, 101, 1, 890);

    insert into MarcaVino values (
        102,
        1,
        'Feast Red',
        'Deep red color with purple hues. An intense experience for only the wildest of men.',
        'Deep red color with purple hues. Dense and intense aromas of fresh forest fruits, strawberries and cherries. Silky and persistent mouthfeel, balanced acidity and rounded tannins, with long aftertaste.',
        14,
        'S',
        1.5,
        16,
        tipo_valor_nt(tipo_valor(2013, 2189, 'litros'), tipo_valor(2014, 2136, 'litros'), tipo_valor(2015, 3036, 'litros')),
        distribucion_exp_nt(distribucion_exp(tipo_valor(2012,800,'litros'),'Estados Unidos'),distribucion_exp(tipo_valor(2013,486,'litros'),'Inglaterra'),distribucion_exp(tipo_valor(2014,2028,'litros'),'Italia')), -- TODO: Conseguir o inventar datos de exportacion
        calificacion_nt(
            calificacion('The Red Rose', tipo_valor(2012, 93, 'puntos')),
            calificacion('Semeli Aetheria Red', tipo_valor(2014, 92, 'puntos'))
        ),
        16,
        18,
        maridajes('Carnes','Pastas', 'Quesos'),
        5.5,
        'Corcho',
        null
    );

    insert into MarcaVino_B_DO (id, fk_marcavino, fk_clasificacionvinos, fk_b_do, fk_bodega, fk_denominaciondeorigen, fk_do_variedadvid, fk_do_region) values
    (102, 102, 1, 101, 101, 101, 101, 101);

    insert into Presentacion values (103, 102, 1, 'Botella', null);
    insert into HistoricoPrecio values (2016, 103, 102, 1, 150);
    insert into HistoricoPrecio values (2017, 103, 102, 1, 164);
    insert into HistoricoPrecio values (2018, 103, 102, 1, 173);

    insert into Presentacion values (104, 102, 1, 'Caja', 6);
    insert into HistoricoPrecio values (2016, 104, 102, 1, 800);
    insert into HistoricoPrecio values (2017, 104, 102, 1, 835);
    insert into HistoricoPrecio values (2018, 104, 102, 1, 890);

    insert into MarcaVino values (
        103,
        2,
        'Thea Mantinia',
        'From a prime growing area in the heart of the Mantinia wine region, and from a single 25 year old vineyard at an altitude of 650m. Careful fermentation in vats and aging on fine lees for five months.',
        'Straw colored with golden hues. On the nose complex aromas of herbs, ripe dried fruit, such as papaya, mango and yuzu, and hints of green fruit. In the mouth the full body and crisp freshness dominate, supported by aromas of bergamot, citron and yuzu, with a very subtle sweet aftertaste.',
        11,
        'S',
        2.5,
        13,
        tipo_valor_nt(tipo_valor(2015, 8050, 'litros'), tipo_valor(2016, 2140, 'litros'), tipo_valor(2017, 2210, 'litros')),
        distribucion_exp_nt(distribucion_exp(tipo_valor(2015,650,'litros'),'Rumania'),distribucion_exp(tipo_valor(2016,952,'litros'),'Alemania'),distribucion_exp(tipo_valor(2017,800,'litros'),'Perú')), -- TODO: Conseguir o inventar datos de exportacion
        calificacion_nt(
            calificacion('Semeli Aetheria White', tipo_valor(2016, 82, 'puntos')),
            calificacion('Semeli Aetheria White', tipo_valor(2017, 87, 'puntos'))
        ),
        300,
        22,
        maridajes('Pescado','Carnes'),
        5.3,
        'Corcho',
        null
    );

    insert into MarcaVino_B_DO (id, fk_marcavino, fk_clasificacionvinos, fk_b_do, fk_bodega, fk_denominaciondeorigen, fk_do_variedadvid, fk_do_region) values
    (103, 103, 2, 101, 101, 101, 101, 101);

    insert into Presentacion values (105, 103, 2, 'Botella', null);
    insert into HistoricoPrecio values (2016, 105, 103, 2, 150);
    insert into HistoricoPrecio values (2017, 105, 103, 2, 165);
    insert into HistoricoPrecio values (2018, 105, 103, 2, 173);

    insert into Presentacion values (106, 103, 2, 'Caja', 8);
    insert into HistoricoPrecio values (2016, 106, 103, 2, 800);
    insert into HistoricoPrecio values (2017, 106, 103, 2, 835);
    insert into HistoricoPrecio values (2018, 106, 103, 2, 890);

----------Bodega Kir-Yianni----------

insert into Region values (102, 'Naoussa', null, 3);
insert into VariedadVid values (104,'Naoussa');
insert into VariedadVid values (105,'Amyndeon');
insert into DenominacionDeOrigen values (104,'Wine of Origin Naoussa', null, 104, 102);
insert into DenominacionDeOrigen values (105,'Wine of Origin Amyndeon', null, 105, 102);

  insert into Bodega values (
      102,
      'Kir-Yianni',
      hechos_hist_nt(hechos_hist(1997, 'Kir-Yianni was founded in 1997 by Yiannis Boutaris, one of the leading figures in the Greek wine industry, when he left the Boutari Wine Group, the premium family wine company that his grandfather established in 1879.')),
      TO_DATE('04-12-1997', 'DD-MM-YYYY'),
      DATOSDECONTACTO(
          conj_telefonos( 2332051100,2332051140),
          null,
          'info@kiryianni.gr',
          'https://kiryianni.gr',
          direccion('Naoussa', '59200', 'YIANNAKOHORI', null),
          personasDeContacto(personaDeContacto('Yiannis','Boutaris','President','YBwhines@gmail.com'))
      ),
      'Our activities are entirely based on the principles of integrated farming. This is a management decision based on a concern to protect the environment as a valuable component of a civilization that is now under threat. Moreover, the integrated farming can ensure the production of high-quality products in Ktima Kir-Yianni.',
      null,
      tipo_valor_nt(tipo_valor(2014, 520000, 'litros'), tipo_valor(2015, 650000, 'litros'), tipo_valor(2016, 480000, 'litros')),
      distribucion_exp_nt(distribucion_exp(tipo_valor(2014, 440000, 'litros'), 'Suiza'),distribucion_exp(tipo_valor(2015, 560000, 'litros'), 'Rusia'),distribucion_exp(tipo_valor(2016, 300000, 'litros'), 'Mexico') ),
      null
  );
  insert into B_DO (id, fk_do_id, fk_do_variedadvid, fk_do_region, fk_bodega) values
  (104, 104, 104, 102, 102);
  insert into B_DO (id, fk_do_id, fk_do_variedadvid, fk_do_region, fk_bodega) values
  (105, 105, 105, 102, 102);

  insert into MarcaVino values (
      104,
      16,
      'Xinomavro',
      'Xinomavro, is a new wine from Kir-Yianni. Grapes are sourced from the Kir-Yianni Estate in Naoussa and selected vineyards of the appellation.',
      'Xinomavro is a light and aromatic wine with soft tannins from selected vineyards in Naoussa.',
      24,
      'S',
      2.9,
      13,
      tipo_valor_nt(tipo_valor(2014, 7100, 'litros'), tipo_valor(2015, 7200, 'litros'), tipo_valor(2016, 10500, 'litros')),
      distribucion_exp_nt(distribucion_exp(tipo_valor(2012,5600,'litros'),'España'),distribucion_exp(tipo_valor(2013,5300,'litros'),'Mexico'),distribucion_exp(tipo_valor(2014,8600,'litros'),'Prusia')),
      calificacion_nt(
          calificacion('ProWein', tipo_valor(2008, 87, 'puntos')),
          calificacion('ProWein', tipo_valor(2009, 90, 'puntos')),
          calificacion('ProWein', tipo_valor(2010, 89, 'puntos'))
      ),
      12,
      16,
      maridajes('Carnes rojas','Pollos'),
      3.36,
      'Corcho',
      null
  );

  insert into MarcaVino_B_DO (id, fk_marcavino, fk_clasificacionvinos, fk_b_do, fk_bodega, fk_denominaciondeorigen, fk_do_variedadvid, fk_do_region) values
  (104, 104, 16, 104, 102, 104, 104, 102);

  insert into Presentacion values (107, 104, 16, 'Botella', null);
  insert into HistoricoPrecio values (2016, 107, 104, 16, 150);
  insert into HistoricoPrecio values (2017, 107, 104, 16, 162);
  insert into HistoricoPrecio values (2018, 107, 104, 16, 173);

  insert into Presentacion values (108, 104, 16, 'Caja', 8);
  insert into HistoricoPrecio values (2016, 108, 104, 16, 822);
  insert into HistoricoPrecio values (2017, 108, 104, 16, 835);
  insert into HistoricoPrecio values (2018, 108, 104, 16, 875);

  insert into MarcaVino values (
      105,
      16,
      'Diaporos',
      'Robust but finely textured, voluminous and extremely age-worthy. A world-class wine, highlighting one of the Ktimas best crus.',
      'Deep red color with purple hues. The nose shows a complex aromatic character composed of successive layers of vanilla and chocolate notes from oak aging, and strawberry aromas typical of a young Xinomavro enhanced with floral hints, such as violet. The intense acidity adds zing to the rich, concentrated body, while the flavor intensity and the robust structure of the wine are a promise of a long aging potential.',
      16,
      'S',
      3.1,
      14,
      tipo_valor_nt(tipo_valor(2013, 3000, 'litros'), tipo_valor(2014, 4253, 'litros'), tipo_valor(2015, 5023, 'litros')),
      distribucion_exp_nt(distribucion_exp(tipo_valor(2012,950,'litros'),'Belgica'),distribucion_exp(tipo_valor(2013,782,'litros'),'China'),distribucion_exp(tipo_valor(2014,893,'litros'),'Australia')), -- TODO: Conseguir o inventar datos de exportacion
      calificacion_nt(
          calificacion('ProWein', tipo_valor(2012, 89, 'puntos')),
          calificacion('ProWein', tipo_valor(2014, 93, 'puntos'))
      ),
      120,
      23,
      maridajes('Quesos'),
      3.31,
      'Corcho',
      null
  );

  insert into MarcaVino_B_DO (id, fk_marcavino, fk_clasificacionvinos, fk_b_do, fk_bodega, fk_denominaciondeorigen, fk_do_variedadvid, fk_do_region) values
  (105, 105, 16, 104, 102, 104, 104, 102);

  insert into Presentacion values (109, 105, 16, 'Botella', null);
  insert into HistoricoPrecio values (2016, 109, 105, 16, 100);
  insert into HistoricoPrecio values (2017, 109, 105, 16, 180);
  insert into HistoricoPrecio values (2018, 109, 105, 16, 200);

  insert into Presentacion values (110, 105, 16, 'Caja', 12);
  insert into HistoricoPrecio values (2016, 110, 105, 16, 1100);
  insert into HistoricoPrecio values (2017, 110, 105, 16, 1150);
  insert into HistoricoPrecio values (2018, 110, 105, 16, 1300);

  insert into MarcaVino values (
      106,
      2,
      'Palpo',
      'Round, with balanced acidity, dense body and flavour intensity. A big, "classical" wine, from our vineyard Palpo, planted in 1990 in Amyndeon.',
      'Produced from Chardonnay grapes sourced from the namesake vineyard of Amyndeon, Palpo 2014 shows complex citrus and white flower aromas complemented by oaky notes reminiscent of brioche, toasted bread and vanilla, while the rich aromatic character and the well-structured body make up a powerful wine with a serious aging potential.',
      13,
      'S',
      1.8,
      13,
      tipo_valor_nt(tipo_valor(2015, 7099, 'litros'), tipo_valor(2016, 2130, 'litros'), tipo_valor(2017, 3215, 'litros')),
      distribucion_exp_nt(distribucion_exp(tipo_valor(2015,650,'litros'),'Prusia'),distribucion_exp(tipo_valor(2016,952,'litros'),'Suecia'),distribucion_exp(tipo_valor(2017,800,'litros'),'Gales')), -- TODO: Conseguir o inventar datos de exportacion
      calificacion_nt(
          calificacion('Whine tasting institute', tipo_valor(2016, 92, 'puntos')),
          calificacion('Whine tasting institute', tipo_valor(2017, 95, 'puntos'))
      ),
      36,
      12,
      maridajes('Pescado','Pollos', 'Pastas'),
      3.38,
      'Corcho',
      null
  );

  insert into MarcaVino_B_DO (id, fk_marcavino, fk_clasificacionvinos, fk_b_do, fk_bodega, fk_denominaciondeorigen, fk_do_variedadvid, fk_do_region) values
  (106, 106, 2, 105, 102, 105, 105, 102);

  insert into Presentacion values (111, 106, 2, 'Botella', null);
  insert into HistoricoPrecio values (2016, 111, 106, 2, 120);
  insert into HistoricoPrecio values (2017, 111, 106, 2, 130);
  insert into HistoricoPrecio values (2018, 111, 106, 2, 165);

  insert into Presentacion values (112, 106, 2, 'Caja', 12);
  insert into HistoricoPrecio values (2016, 112, 106, 2, 800);
  insert into HistoricoPrecio values (2017, 112, 106, 2, 840);
  insert into HistoricoPrecio values (2018, 112, 106, 2, 887);

----------Bodega Boutari----------

insert into Region values (103, 'Peloponnese', null, 3);
insert into VariedadVid values (106,'Heraklion');
insert into DenominacionDeOrigen values (106,'Regional Wine of Heraklion', null, 106, 103);

  insert into Bodega values (
      103,
      'Boutari',
      hechos_hist_nt(hechos_hist(1879, 'The Boutari Company was established in 1879 in Naoussa. Today with over 134 years of experience in the wine business, it is one of the top wineries in Greece and an ambassador of Greek wine all over the world. Boutari wines are exported to over 45 countries and have won over 370 medals in international wine competitions. Boutari wine-makers give great emphasis to making quality wines with a distinct character that represents fully the potential of the variety they come from.')),
      TO_DATE('13-05-1879', 'DD-MM-YYYY'),
      DATOSDECONTACTO(
          conj_telefonos( 2106605200,2332059700),
          null,
          'info@boutari.gr',
          'http://www.boutari.gr',
          direccion('Athens', '19009', 'Marathonos avenue', null),
          personasDeContacto(personaDeContacto('Roxanne','Masta','Chief Secretary','ktimatsa@gmail.com'))
      ),
      'To preserve and modernize viticulture in greece, we do naught but the best wines even the Gods could ask for.',
      null,
      tipo_valor_nt(tipo_valor(2014, 600000, 'litros'), tipo_valor(2015, 660000, 'litros'), tipo_valor(2016, 590000, 'litros')),
      distribucion_exp_nt(distribucion_exp(tipo_valor(2014, 440000, 'litros'), 'Japon'),distribucion_exp(tipo_valor(2015, 360000, 'litros'), 'India'),distribucion_exp(tipo_valor(2016, 250000, 'litros'), 'Alemania') ),
      null
  );
  insert into B_DO (id, fk_do_id, fk_do_variedadvid, fk_do_region, fk_bodega) values
  (106, 106, 106, 103, 103);

  insert into MarcaVino values (
      107,
      2,
      'Oropedio',
      '“OROPEDIO” meaning “High Plateau” in Greek is a wine underlining the ultimate expression of the indigenous Moschofilero variety. Grown at an altitude of 650m in the region of Mantinia, centre of the Peloponnese, in southern Greece. The grapes are protected by the mountains that surround the “plateau” which allows for the development of their precious aromas. Hand-picking of the grapes and manual sorting upon delivery, preserve the quality of the wine while its short stay in oak barrels gives it its finesse. ',
      'Visual: A wine with a deep pale yellow gold hue
      Aroma: A unique bouquet made of wild white roses and citrus combined with a touch of grapefruit as secondary aromas.
      Taste: A very food-friendly wine, opulent and rich on the mouthfeel and quite crisp which gives it extra freshness. One of its powerful attributes is the long and lingering aftertaste which exerts aromas very typical to moschophilero.',
      18,
      'S',
      2.9,
      15,
      tipo_valor_nt(tipo_valor(2014, 7100, 'litros'), tipo_valor(2015, 7200, 'litros'), tipo_valor(2016, 10500, 'litros')),
      distribucion_exp_nt(distribucion_exp(tipo_valor(2012,5600,'litros'),'Mexico'),distribucion_exp(tipo_valor(2013,5300,'litros'),'Portugal'),distribucion_exp(tipo_valor(2014,8600,'litros'),'Belgica')),
      calificacion_nt(
          calificacion('ProWein', tipo_valor(2008, 88, 'puntos')),
          calificacion('ProWein', tipo_valor(2009, 92, 'puntos')),
          calificacion('ProWein', tipo_valor(2010, 85, 'puntos'))
      ),
      13,
      17,
      maridajes('Ensaladas'),
      3.4,
      'Corcho',
      null
  );

  insert into MarcaVino_B_DO (id, fk_marcavino, fk_clasificacionvinos, fk_b_do, fk_bodega, fk_denominaciondeorigen, fk_do_variedadvid, fk_do_region) values
  (107, 107, 2, 106, 103, 106, 106, 103);

  insert into Presentacion values (113, 107, 2, 'Botella', null);
  insert into HistoricoPrecio values (2016, 113, 107, 2, 120);
  insert into HistoricoPrecio values (2017, 113, 107, 2, 140);
  insert into HistoricoPrecio values (2018, 113, 107, 2, 200);

  insert into Presentacion values (114, 107, 2, 'Caja', 12);
  insert into HistoricoPrecio values (2016, 114, 107, 2, 721);
  insert into HistoricoPrecio values (2017, 114, 107, 2, 723);
  insert into HistoricoPrecio values (2018, 114, 107, 2, 735);

  insert into MarcaVino values (
      108,
      2,
      'Fantaxometocho',
      'This special blend promises to offer an explosion of aromas. Following various experimentations with the blend, Malvasia Aromatica harmoniously combined with the cosmopolitan Chardonnay and the fruity Vilana, offers a truly unique result.',
      'Brilliant wine, yellow white colour with greenish tints. The complex aromatic character of the wine is reminiscent of lemon blossom, pineapple and notes of honey. Its palette is rounded by vanilla elements, originating from its short stay in barrels. Full body, rich, well balanced, with a high acidity and alcoholic content. It offers a long aftertaste.',
      6,
      'S',
      3.1,
      15,
      tipo_valor_nt(tipo_valor(2013, 4000, 'litros'), tipo_valor(2014, 4300, 'litros'), tipo_valor(2015, 4250, 'litros')),
      distribucion_exp_nt(distribucion_exp(tipo_valor(2012,850,'litros'),'Portugal'),distribucion_exp(tipo_valor(2013,860,'litros'),'India'),distribucion_exp(tipo_valor(2014,752,'litros'),'Canada')), -- TODO: Conseguir o inventar datos de exportacion
      calificacion_nt(
          calificacion('ProWein', tipo_valor(2015, 91, 'puntos')),
          calificacion('ProWein', tipo_valor(2016, 95, 'puntos'))
      ),
      24,
      18,
      maridajes('Pescados', 'Salsas'),
      3.31,
      'Corcho',
      null
  );

  insert into MarcaVino_B_DO (id, fk_marcavino, fk_clasificacionvinos, fk_b_do, fk_bodega, fk_denominaciondeorigen, fk_do_variedadvid, fk_do_region) values
  (108, 108, 2, 106, 103, 106, 106, 103);

  insert into Presentacion values (115, 108, 2, 'Botella', null);
  insert into HistoricoPrecio values (2016, 115, 108, 2, 220);
  insert into HistoricoPrecio values (2017, 115, 108, 2, 262);
  insert into HistoricoPrecio values (2018, 115, 108, 2, 310);

  insert into Presentacion values (116, 108, 2, 'Caja', 12);
  insert into HistoricoPrecio values (2016, 116, 108, 2, 1225);
  insert into HistoricoPrecio values (2017, 116, 108, 2, 1228);
  insert into HistoricoPrecio values (2018, 116, 108, 2, 1350);
INSERT INTO CatadorExperto VALUES (
    2, 
    'Robert', 
    'Parker', 
    to_date('23-07-1947', 'DD-MM-YYYY'), 
    null,
    hechos_hist_nt(),
    lugar('Baltimore', 'Estados Unidos'),
    publicaciones_nt(
        'Parker''s wine buyer''s guide',
        'Parker''s wine bargains',
        'The wine''s advocate'
    ),
    'M',
    4
);

INSERT INTO CatadorExperto VALUES (
    3, 
    'Steve', 
    'Spurrier', 
    to_date('12-02-1941', 'DD-MM-YYYY'), 
    null,
    hechos_hist_nt(),
    lugar('London', 'United Kingdom'),
    publicaciones_nt(
        'The Academie Du Vin Guide to French Wines',
        'How to Buy Fine Wines',
        'Academie Du Vin Wine Course',
        'Clarke and Spurrier''s Fine Wine Guide'
    ),
    'M',
    2
);

INSERT INTO Edicion VALUES  (
    1,
    datosBancarios(
        'Union Espanola de Catadores (BACCHUS 2019)',
        'La Caixa',
        'ES78 2100 2254 10 0200151989',
        'CAIXESBBXXX'
    ),
    to_date('20-02-2018', 'DD-MM-YYYY'),
    to_date('22-02-2018', 'DD-MM-YYYY'),
    to_date('07-03-2018', 'DD-MM-YYYY'),
    to_date('11-03-2018', 'DD-MM-YYYY'),
    128,
    direccion(
        'Madrid',
        '28320',
        'C/ Alcotanes 22 – Polígono Industrial La Estación',
        '28320 PINTO (Madrid), Espana'
    ),
    costoInscripcion_nt(
        costoInscripcion(1,150,'Espana'),
        costoInscripcion(2,298,'Espana'),
        costoInscripcion(3,443,'Espana'),
        costoInscripcion(1,124,'Resto de Europa'),
        costoInscripcion(2,246,'Resto de Europa'),
        costoInscripcion(3,366,'Resto de Europa')
    ),
    lugar('Madrid', 'Espana'),
    unidadMonetaria('Euro', 'EUR'),
    'info@uec.es',
    DATOSDECONTACTO(
        conj_telefonos(34914293477, 34914291238), 
        null, 
        'info@uec.es', 
        'http://www.concursobacchus.com/',
        direccion('Madrid', '28014', 'C/ Lope de Vega, 27, Madrid, España', null),
        null
    ),
    1
);

insert into Juez values (1, 1);
insert into Juez values (2, 1);
insert into Juez values (3, 1);

insert into Inscripcion values (
    1,
    to_date('10-02-2018', 'DD-MM-YYYY'),
    null,
    1,
    4,
    null
);

insert into Inscripcion values (
    2,
    to_date('12-02-2018', 'DD-MM-YYYY'),
    null,
    1,
    54,
    null
);

insert into Inscripcion values (
    3,
    to_date('08-02-2018', 'DD-MM-YYYY'),
    null,
    1,
    51,
    null
);

-- Justinos Tinta Negra en Bacchus 2019
insert into MuestraCompite values (
    1,
    5,
    18,
    1,
    2016,
    premio_nt()
);

--  Crystallum The Agnes Chardonnay en Bacchus 2019
insert into MuestraCompite values (
    2,
    57,
    13,
    2,
    2016,
    premio_nt()
);

-- Opus One Overture en Bacchus 2019
insert into MuestraCompite values (
    3,
    51,
    16,
    3,
    2017,
    premio_nt()
);


insert into CataExperto values (
    1,
    to_date('08-03-2018', 'DD-MM-YYYY'),
    valoracion_nt(
        valoracion('Fase visual', 9, 'Excelente reflejo de luz'),
        valoracion('Fase olfativa', 26, 'Buena intensidad pobre calidad'),
        valoracion('Fase gustativa', 45, 'Muy sabroso'),
        valoracion('Armonia', 18, null)
    ),
    null,
    1,
    1
);
insert into CataExperto values (
    2,
    to_date('08-03-2018', 'DD-MM-YYYY'),
    valoracion_nt(
        valoracion('Fase visual', 9, null),
        valoracion('Fase olfativa', 23, null),
        valoracion('Fase gustativa', 40, null),
        valoracion('Armonia', 27, null)
    ),
    null,
    2,
    1
);

insert into CataExperto values (
    3,
    to_date('08-03-2018', 'DD-MM-YYYY'),
    valoracion_nt(
        valoracion('Fase visual', 6, null),
        valoracion('Fase olfativa', 20, null),
        valoracion('Fase gustativa', 35, null),
        valoracion('Armonia', 15, null)
    ),
    null,
    3,
    1
);


insert into CataExperto values (
    4,
    to_date('09-03-2018', 'DD-MM-YYYY'),
    valoracion_nt(
        valoracion('Fase visual', 3, null),
        valoracion('Fase olfativa', 12, null),
        valoracion('Fase gustativa', 26, null),
        valoracion('Armonia', 9, null)
    ),
    null,
    1,
    2
);
insert into CataExperto values (
    5,
    to_date('09-03-2018', 'DD-MM-YYYY'),
    valoracion_nt(
        valoracion('Fase visual', 5, null),
        valoracion('Fase olfativa', 18, null),
        valoracion('Fase gustativa', 20, null),
        valoracion('Armonia', 12, null)
    ),
    null,
    2,
    2
);

insert into CataExperto values (
    6,
    to_date('09-03-2018', 'DD-MM-YYYY'),
    valoracion_nt(
        valoracion('Fase visual', 6, null),
        valoracion('Fase olfativa', 20, null),
        valoracion('Fase gustativa', 20, null),
        valoracion('Armonia', 20, null)
    ),
    null,
    3,
    2
);


insert into CataExperto values (
    7,
    to_date('10-03-2018', 'DD-MM-YYYY'),
    valoracion_nt(
        valoracion('Fase visual', 8, null),
        valoracion('Fase olfativa', 30, null),
        valoracion('Fase gustativa', 40, null),
        valoracion('Armonia', 18, null)
    ),
    null,
    1,
    3
);

insert into CataExperto values (
    8,
    to_date('10-03-2018', 'DD-MM-YYYY'),
    valoracion_nt(
        valoracion('Fase visual', 9, null),
        valoracion('Fase olfativa', 32, null),
        valoracion('Fase gustativa', 38, null),
        valoracion('Armonia', 25, null)
    ),
    null,
    2,
    3
);

insert into CataExperto values (
    9,
    to_date('10-03-2018', 'DD-MM-YYYY'),
    valoracion_nt(
        valoracion('Fase visual', 8, null),
        valoracion('Fase olfativa', 35, null),
        valoracion('Fase gustativa', 20, null),
        valoracion('Armonia', 23, null)
    ),
    null,
    3,
    3
);

-- TODO: Insertar una muestracompite mas a la edicion que sea posicion 4 y no gane nada


--- Concurso de catadores-----

INSERT INTO Concurso VALUES (
    2,
    'Baco Catadores',
    DATOSDECONTACTO(
        conj_telefonos(34914293477, 34914291238), 
        null, 
        'info@tomelloso.es', 
        'http://www.tomelloso.es/',
        direccion('Madrid', '28014', 'C/ Lope de Vega, 27, Madrid, España', null),
        null
    ),
    'Comparativa',
    'S',
    premio_nt(),
    escala_nt(),
    'La práctica totalidad del atlas vinícola escoge a Baco como escaparate inmejorable de sus elaboraciones. Los cinco continentes vinícolas: Europa, América, África, Asia y Oceanía cuentan año tras año con numerosos representantes en este encuentro global en el que se convierte Bacchus. Una prueba más del prestigio y repercusión que alcanza a nivel internacional la gran cita española con el mundo del vino.'
);

INSERT INTO Organizador VALUES 
(51, 'Asociacion de Tomelloso', null);

INSERT INTO Organizador VALUES 
(52, 'Bodegas Simbolo', null);

INSERT INTO P_O VALUES
(51, 51, 1);

INSERT INTO P_O VALUES
(52, 52, 2);

INSERT INTO P_O VALUES
(53, 52, 4);


INSERT INTO Organizador_Concurso VALUES
(51, 51, 2);

INSERT INTO Organizador_Concurso VALUES
(52, 52, 2);

INSERT INTO CatadorExperto VALUES (
    51, 
    'Romeo', 
    'Santos', 
    to_date('09-06-1968', 'DD-MM-YYYY'), 
    null,
    hechos_hist_nt(),
    lugar('Lisboa', 'Portugal'),
    publicaciones_nt(),
    'M',
    2
);

INSERT INTO CatadorExperto VALUES (
    52, 
    'Anuel', 
    'AA', 
    to_date('09-06-1978', 'DD-MM-YYYY'), 
    null,
    hechos_hist_nt(),
    lugar('Lisboa', 'Portugal'),
    publicaciones_nt(),
    'M',
    4
);

insert into Edicion values(
51,
null,
TO_DATE('12-06-2018', 'DD-MM-YYYY'),
null,
TO_DATE('12-06-2018', 'DD-MM-YYYY'),
TO_DATE('12-06-2018', 'DD-MM-YYYY'),
null,
direccion('Hermanus', '7200', '2 Harbour Rd', null),
costoInscripcion_nt(),
lugar('test','test2'),
unidadMonetaria('Rand Sudafricano', 'R'),
null,
DATOSDECONTACTO(
        conj_telefonos(270832355748,4740000787), 
        null, 
        'customerservice@crystallumwines.com', 
        'http://www.crystallumwines.com/',
        direccion('Hermanus', '7200', '2 Harbour Rd', null),
        personasDeContacto(personaDeContacto('David','Nel','Sales','steele.nel@gmail.com'))
),
2
);

commit;
