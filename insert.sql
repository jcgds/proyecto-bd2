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

insert into Pais values (
    1, 
    'Portugal', 
    'Europa', 
    tipo_valor_nt(), -- superficie viï¿½edo
    tipo_valor_nt(
        tipo_valor(2011, 5609000, 'litros'),
        tipo_valor(2012, 6140000, 'litros'),
        tipo_valor(2013, 6740000, 'litros')
    ), 
    distribucion_exp_nt(), 
    unidadMonetaria('Euro', 'EUR'), 
    bfilename('mapas_regionales', 'portugal.jpg'), 
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
        direccion('Freixo de Espada Ã© Cinta', '5180-909', 'Apartado 17 - 5180-909 Freixo de Espada Ã© Cinta', null),
        personasDeContacto(personaDeContacto('JosÃ©','Menezes','Winemaker','douro@companhiadasquintas.pt'))
    ),
    'Created with the purpose of becoming one of the most important players in the Portuguese wine business.' || 
    ' Its strategy is based on the development of high quality estate wines from 250 hectares of own vineyards,' || 
    ' planted in the major Portuguese wine regions. The company aims to achieve sustained growth, with main focus on foreign markets.',
    'TODO: Tal vez deberia poder ser null (Descripcion general vinos)',
    tipo_valor_nt(),  -- TODO: Conseguir y llenar esta tabla con 3 anios
    distribucion_exp_nt(), -- TODO: Conseguir y llenar esta tabla con 3 anios
    null -- TODO: Crear bodega Companhia Das Quintas y colocar su id
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
    tipo_valor_nt(tipo_valor(2011, 15348, 'litros'), tipo_valor(2012, 15348, 'litros'), tipo_valor(2013, 21126, 'litros')),
    distribucion_exp_nt(), -- TODO: Conseguir o inventar datos de exportacion
    calificacion_nt(
        calificacion('Wine Enthusiast Magazine', tipo_valor(2012, 91, 'puntos')),
        calificacion('Wine Enthusiast Magazine', tipo_valor(2011, 92, 'puntos')),
        calificacion('Wine Advocate/Robert Parker', tipo_valor(2011, 90, 'puntos'))
    ),
    6,
    20,
    maridajes('Carnes rojas', 'Asados', 'Quesos de sabor intenso'),
    5.1,
    'Corcho',
    null -- TODO: Ver como se sube un BLOB
);

insert into Presentacion values (1, 1, 17, 'Botella', null);
insert into HistoricoPrecio values (2016, 1, 1, 17, 25);
insert into HistoricoPrecio values (2017, 1, 1, 17, 34);
insert into HistoricoPrecio values (2018, 1, 1, 17, 18);

insert into Presentacion values (2, 1, 17, 'Caja', 6);
insert into HistoricoPrecio values (2016, 2, 1, 17, 139.99);
insert into HistoricoPrecio values (2017, 2, 1, 17, 195.99);
insert into HistoricoPrecio values (2018, 2, 1, 17, 99.99);

insert into B_DO (id, fk_do_id, fk_do_variedadvid, fk_do_region, fk_bodega) values 
(1, 1, 1, 1, 1); -- B_DO Entre bodega Quinta Da Fronteira y la Douro Touriga Nacional

insert into B_DO (id, fk_do_id, fk_do_variedadvid, fk_do_region, fk_bodega) values 
(2, 2, 2, 1, 1); -- B_DO Entre bodega Quinta Da Fronteira y la Douro Touriga Franca

insert into B_DO (id, fk_do_id, fk_do_variedadvid, fk_do_region, fk_bodega) values 
(3, 3, 5, 1, 1); -- B_DO Entre bodega Quinta Da Fronteira y la Douro Tinta Roriz

insert into MarcaVino_B_DO (id, fk_marcavino, fk_clasificacionvinos, fk_b_do, fk_bodega, fk_denominaciondeorigen, fk_do_variedadvid, fk_do_region) values
(1, 1, 17, 1, 1, 1, 1, 1); -- Quinta Da Fronteira - Douro Touriga Nacional - Reserva Tinto

insert into MarcaVino_B_DO (id, fk_marcavino, fk_clasificacionvinos, fk_b_do, fk_bodega, fk_denominaciondeorigen, fk_do_variedadvid, fk_do_region) values
(2, 1, 17, 2, 1, 2, 2, 1); -- Quinta Da Fronteira - Douro Touriga Franca - Reserva Tinto

insert into MarcaVino_B_DO (id, fk_marcavino, fk_clasificacionvinos, fk_b_do, fk_bodega, fk_denominaciondeorigen, fk_do_variedadvid, fk_do_region) values
(3, 1, 17, 3, 1, 3, 5, 1); -- Quinta Da Fronteira - Douro Tinta Roriz - Reserva Tinto

insert into VariedadVid values (3,'Viosinho');
insert into DenominacionDeOrigen (id, nombre, descripcion, FK_VariedadVid, FK_Region) values 
(4,'Douro - Viosinho', null, 3, 1);
insert into B_DO (id, fk_do_id, fk_do_variedadvid, fk_do_region, fk_bodega) values 
(4, 4, 3, 1, 1); -- B_DO Entre bodega Quinta Da Fronteira y la Douro Viosinho

insert into VariedadVid values (4,'Codega do Lorinho');
insert into DenominacionDeOrigen (id, nombre, descripcion, FK_VariedadVid, FK_Region) values 
(5,'Douro - Codega do Lorinho', null, 4, 1);
insert into B_DO (id, fk_do_id, fk_do_variedadvid, fk_do_region, fk_bodega) values 
(5, 5, 4, 1, 1); -- B_DO Entre bodega Quinta Da Fronteira y la Douro Codega do Lorinho

insert into MarcaVino values (
    3,
    9,
    'Fronteira White',
    'Grapes were handpicked to small 16 kg boxes. A soft pressing was followed by a cold settling of the must, which, after reaching the required purity, was fermented for 4 weeks in stainless steel vats at a controlled temperature of 14 -16Â°C. The wine aged 5 months on fine lees in stainless steel vats which improved its complexity.',
    'Bright citrus coloured wine with lush aroma displaying hints of white fruit (peach) and tropical (pineapple), with some mineral notes typical of the Douro region. On the palate it shows great balance, lively acidity and a lingering after taste.',
    11,
    'N',
    3,
    12.5,
    tipo_valor_nt(tipo_valor(2011, 58500, 'litros'), tipo_valor(2012, 63500, 'litros'), tipo_valor(2013, 67500, 'litros')),
    distribucion_exp_nt(), -- TODO: Conseguir o inventar datos de exportacion
    calificacion_nt(
        calificacion('Wine Enthusiast Magazine', tipo_valor(2015, 88, 'puntos'))
    ),
    5,
    8,
    maridajes('Pescados', 'Ensaladas', 'Pastas', 'Carnes blancas'),
    6.75,
    'Corcho 1+1',
    null -- TODO: Ver como se sube un BLOB
);

insert into Presentacion values (3, 3, 9, 'Botella', null);
insert into HistoricoPrecio values (2016, 3, 3, 9, 10);
insert into HistoricoPrecio values (2017, 3, 3, 9, 12);
insert into HistoricoPrecio values (2018, 3, 3, 9, 13);

insert into Presentacion values (4, 3, 9, 'Caja', 6);
insert into HistoricoPrecio values (2016, 4, 3, 9, 55.2);
insert into HistoricoPrecio values (2017, 4, 3, 9, 67.35);
insert into HistoricoPrecio values (2018, 4, 3, 9, 73.5);

insert into MarcaVino_B_DO (id, fk_marcavino, fk_clasificacionvinos, fk_b_do, fk_bodega, fk_denominaciondeorigen, fk_do_variedadvid, fk_do_region) values
(4, 3, 9, 4, 1, 4, 3, 1); -- Quinta Da Fronteira - Douro Viosinho - Fronteira White

insert into MarcaVino_B_DO (id, fk_marcavino, fk_clasificacionvinos, fk_b_do, fk_bodega, fk_denominaciondeorigen, fk_do_variedadvid, fk_do_region) values
(5, 3, 9, 5, 1, 5, 4, 1); -- Quinta Da Fronteira - Douro Codega do Lorinho - Fronteira White
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
    -- TODO: En este caso como son sub bodegas de Companhia Das Quintas la mision deberia ser la misma?
    'Created with the purpose of becoming one of the most important players in the Portuguese wine business.' || 
    ' Its strategy is based on the development of high quality estate wines from 250 hectares of own vineyards,' || 
    ' planted in the major Portuguese wine regions. The company aims to achieve sustained growth, with main focus on foreign markets.',
    'TODO: Tal vez deberia poder ser null (Descripcion general vinos)',
    tipo_valor_nt(),
    distribucion_exp_nt(),
    null -- TODO: Crear bodega Companhia Das Quintas y colocar su id
);

insert into B_DO (id, fk_do_id, fk_do_variedadvid, fk_do_region, fk_bodega) values 
(6, 6, 1, 3, 3); -- B_DO Entre bodega Herdade Da Farizoa y la IG Alentejano Touriga Nacional
insert into B_DO (id, fk_do_id, fk_do_variedadvid, fk_do_region, fk_bodega) values 
(7, 7, 6, 3, 3); -- B_DO Entre bodega Herdade Da Farizoa y la IG Alentejano Aragonez

insert into MarcaVino values (
    4,
    13,
    'Portas Da Herdade Reserva',
    'Grapes were de-stemmed without crushing, followed by 3 days cold maceration. Fermentation was done at 24 ° C with one daily riddle. Malolactic fermentation was done in vats. The final blend aged in French oak barrels for 9 months.',
    'Intense ruby colour and complex aromas with outstanding notes of violet, cherry and chocolate. In the mouth it is full and elegant, with good structure and concentration. Long after-taste confirming its aromatic notes.',
    16,
    'S',
    0.3,
    13.5,
    tipo_valor_nt(tipo_valor(2011, 26500, 'litros'), tipo_valor(2012, 34250, 'litros'), tipo_valor(2013, 30750, 'litros')),
    distribucion_exp_nt(), -- TODO: Conseguir o inventar datos de exportacion
    calificacion_nt(),
    9,
    10,
    maridajes('Carnes ahumadas', 'Pastas', 'Quesos surtidos'),
    5.2,
    'Natural',
    EMPTY_BLOB()
);

insert into MarcaVino_B_DO (id, fk_marcavino, fk_clasificacionvinos, fk_b_do, fk_bodega, fk_denominaciondeorigen, fk_do_variedadvid, fk_do_region) values
(6, 4, 13, 6, 3, 6, 1, 3); -- Herdade Da Farizoa - IG Alentejano Touriga Nacional - Portas Da Herdade Reserva
insert into MarcaVino_B_DO (id, fk_marcavino, fk_clasificacionvinos, fk_b_do, fk_bodega, fk_denominaciondeorigen, fk_do_variedadvid, fk_do_region) values
(7, 4, 13, 7, 3, 7, 6, 3); -- Herdade Da Farizoa - IG Alentejano Aragonez - Portas Da Herdade Reserva

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
        direccion('Madeira', '9125-042', 'Parque Industrial da Cancela', 'Caniço, Madeira'),
        personasDeContacto()
    ),
    -- TODO: En este caso como son sub bodegas de Companhia Das Quintas la mision deberia ser la misma?
    'Durante toda a sua história a Justino''s Madeira tem vindo, gradualmente, a conquistar e a confirmar a sua presença, um pouco por todo o mundo, com especial destaque para a França, Alemanha, Inglaterra, Áustria, Suíça, Polónia, Benelux, Espanha e Escandinávia, e também E.U.A., Canadá, Brasil e Japão.',
    'A empresa dispõe actualmente de um dos maiores stocks de vinhos na Ilha da Madeira, constituído por vinhos de elevada qualidade, envelhecidos em cascos de carvalho, que lhe permitem dar resposta às solicitações dos mercados mais exigentes e selectivos.',
    tipo_valor_nt(),
    distribucion_exp_nt(),
    null
);

insert into B_DO (id, fk_do_id, fk_do_variedadvid, fk_do_region, fk_bodega) values 
(8, 8, 7, 4, 4); -- B_DO Entre bodega Justino's Madeira y la DO Madeira

insert into MarcaVino values (
    5,
    18,
    'Colombo Madeira Tinta Negra',
    'Desengaçe total, esmagamento e prensagem. Vinificação em bica-aberta. Fermentado totalmente em cuba de aço inoxidável com controlo de temperatura e tempos de remontagem. Interrupção da fermentação pela adição de álcool vínico 96º. Adição de álcool vínico feita após 2 - 3 dias de fermentação de forma a manter a quantidade de açúcares desejada. Vinificação feita de acordo com os métodos tradicionais.',
    'Atrativa e brilhante cor âmbar medianamente carregada. Elegante e complexo aroma, rico e com notas de melaço, bolo de mel, caramelo, noz e mel quente. Elegante em boca, intenso com pronunciadas notas de caramelo de fruta.',
    19,
    'S',
    121.3,
    19,
    tipo_valor_nt(), --1999, 1998
    distribucion_exp_nt(), -- TODO: Conseguir o inventar datos de exportacion
    calificacion_nt(),
    4,
    5,
    maridajes('Fruta tropical', 'Chocolate negro', 'Tortas de frutas', 'Cafe'),
    5.45,
    'Natural',
    EMPTY_BLOB()
);

insert into MarcaVino_B_DO (id, fk_marcavino, fk_clasificacionvinos, fk_b_do, fk_bodega, fk_denominaciondeorigen, fk_do_variedadvid, fk_do_region) values
(8, 5, 18, 8, 4, 8, 7, 4); -- Justino's Madeira - DO Madeira Tinta Negra - Colombo Madeira Tinta Negra


---- / Fin Bodega Justino's Madeira ------------------------------------------------------------------------------------------------------------------------------------------


insert into Pais values (4, 'Estados Unidos', 'America', tipo_valor_nt(), tipo_valor_nt(tipo_valor(2016,26900000,'hl')), distribucion_exp_nt(), 
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
    'En Opus One la esencia del tiempo se expresa por el carï¿½cter de cada cosecha.' || 
    'El lugar, a menudo definido como "terroir", representa la geografï¿½a, el clima y el elemento humano esencial que se captura en el equilibrio 
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
    'Overture es una expresiï¿½n atemporal de los viï¿½edos de nuestra finca, con cuerpo pero accesible en su juventud. Overture muestra una abundancia de aromas y sabores de frutas silvestres con un paladar medio suave y sutil.',
    'Deep dark fruits and cherries. Leather, black pepper. Light but long lasting taste of grapes at the end. Paired with garlic roasted lamb rack',
    14,
    'N',
    1.1,
    14,
    tipo_valor_nt(tipo_valor(2011, 26654, 'litros'), tipo_valor(2012, 36225, 'litros'), tipo_valor(2013, 14562, 'litros')),
    distribucion_exp_nt(distribucion_exp('Portugal',tipo_valor(2012,23432,'litros')),distribucion_exp('Mexico',tipo_valor(2013,23432,'litros')),distribucion_exp('Colombia',tipo_valor(2014,23432,'litros'))), -- TODO: Conseguir o inventar datos de exportacion
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
insert into MarcaVino values (
    52,
    16,
    'Cabernet Sauvignon',
    'The Cabernet Sauvignon from the 2015 vintage is inky purple in color with aromas of dense blackberry jam, cassis and balsamic followed by a layering complexity throughout the mouthfeel of supple, 
    sweet tannins with expressive ripe plum, vanilla and rich black fruit.',
    'Grapes were sorted and cold soaked prior to fermentation. The wine was aged for eighteen months in 40% new oak barrels (65% French, 35% American) and 60% one- to two-year-old French and American oak barrels before bottling. The barrel coopers used included Ermitage, FranÃ§ois FrÃ¨res, Demptos (French & American), 
    Canton (American), Barrel Associates (American) and Orion',
    14,
    'N',
    1.1,
    14,
    tipo_valor_nt(tipo_valor(2011, 26654, 'litros'), tipo_valor(2012, 36225, 'litros'), tipo_valor(2013, 14562, 'litros')),
    distribucion_exp_nt(distribucion_exp('Portugal',tipo_valor(2012,23432,'litros')),distribucion_exp('Mexico',tipo_valor(2013,23432,'litros')),distribucion_exp('Colombia',tipo_valor(2014,23432,'litros'))), -- TODO: Conseguir o inventar datos de exportacion
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
    distribucion_exp_nt(distribucion_exp('Portugal',tipo_valor(2012,23432,'litros')),distribucion_exp('Mexico',tipo_valor(2013,23432,'litros')),distribucion_exp('Colombia',tipo_valor(2014,23432,'litros'))), -- TODO: Conseguir o inventar datos de exportacion
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
(53, 53, 16, 52, 52, 55, 55, 42);







