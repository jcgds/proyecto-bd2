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
    tipo_valor_nt(), -- superficie vi�edo
    tipo_valor_nt(), 
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
        direccion('Freixo de Espada é Cinta', '5180-909', 'Apartado 17 - 5180-909 Freixo de Espada é Cinta', null),
        personasDeContacto(personaDeContacto('José','Menezes','Winemaker','douro@companhiadasquintas.pt'))
    ),
    'Created with the purpose of becoming one of the most important players in the Portuguese wine business.' || 
    ' Its strategy is based on the development of high quality estate wines from 250 hectares of own vineyards,' || 
    ' planted in the major Portuguese wine regions. The company aims to achieve sustained growth, with main focus on foreign markets.',
    'TODO: Tal vez deberia poder ser null (Descripcion general vinos)',
    tipo_valor_nt(),
    distribucion_exp_nt(),
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
    tipo_valor_nt(
        tipo_valor(2011, 15348, 'litros'), 
        tipo_valor(2012, 15348, 'litros'), 
        tipo_valor(2013, 21126, 'litros')
    ),
    distribucion_exp_nt(
        distribucion_exp(tipo_valor(2011, 4, 'litros'), 'Canada'),
        distribucion_exp(tipo_valor(2011, 5, 'litros'), 'Italia'),
        distribucion_exp(tipo_valor(2012, 10, 'litros'), 'Alemania')
    ),
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

-- B_DO Entre bodega Quinta Da Fronteira y la Douro Touriga Nacional
insert into B_DO (id, fk_do_id, fk_do_variedadvid, fk_do_region, fk_bodega) values 
(1, 1, 1, 1, 1); 

-- B_DO Entre bodega Quinta Da Fronteira y la Douro Touriga Franca
insert into B_DO (id, fk_do_id, fk_do_variedadvid, fk_do_region, fk_bodega) values 
(2, 2, 2, 1, 1); 

-- B_DO Entre bodega Quinta Da Fronteira y la Douro Tinta Roriz
insert into B_DO (id, fk_do_id, fk_do_variedadvid, fk_do_region, fk_bodega) values 
(3, 3, 5, 1, 1); 

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

insert into VariedadVid values (4,'Codega do Lorinho');
insert into DenominacionDeOrigen (id, nombre, descripcion, FK_VariedadVid, FK_Region) values 
(5,'Douro - Codega do Lorinho', null, 4, 1);

-- B_DO Entre bodega Quinta Da Fronteira y la Douro Codega do Lorinho
insert into B_DO (id, fk_do_id, fk_do_variedadvid, fk_do_region, fk_bodega) values 
(5, 5, 4, 1, 1); 

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
        distribucion_exp(tipo_valor(2011, 6, 'litros'), 'Canada'),
        distribucion_exp(tipo_valor(2011, 5, 'litros'), 'Italia'),
        distribucion_exp(tipo_valor(2012, 10, 'litros'), 'Alemania')
    ),
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
    -- TODO: En este caso como son sub bodegas de Companhia Das Quintas la mision deberia ser la misma?
    'Created with the purpose of becoming one of the most important players in the Portuguese wine business.' || 
    ' Its strategy is based on the development of high quality estate wines from 250 hectares of own vineyards,' || 
    ' planted in the major Portuguese wine regions. The company aims to achieve sustained growth, with main focus on foreign markets.',
    'TODO: Tal vez deberia poder ser null (Descripcion general vinos)',
    tipo_valor_nt(),
    distribucion_exp_nt(),
    null -- TODO: Crear bodega Companhia Das Quintas y colocar su id
);

-- B_DO Entre bodega Herdade Da Farizoa y la IG Alentejano Touriga Nacional
insert into B_DO (id, fk_do_id, fk_do_variedadvid, fk_do_region, fk_bodega) values 
(6, 6, 1, 3, 3); 

-- B_DO Entre bodega Herdade Da Farizoa y la IG Alentejano Aragonez
insert into B_DO (id, fk_do_id, fk_do_variedadvid, fk_do_region, fk_bodega) values 
(7, 7, 6, 3, 3); 

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
        direccion('Madeira', '9125-042', 'Parque Industrial da Cancela', 'Cani�o, Madeira'),
        personasDeContacto()
    ),
    -- TODO: En este caso como son sub bodegas de Companhia Das Quintas la mision deberia ser la misma?
    'Durante toda a sua hist�ria a Justino''s Madeira tem vindo, gradualmente, a conquistar e a confirmar a sua presen�a, um pouco por todo o mundo, com especial destaque para a Fran�a, Alemanha, Inglaterra, �ustria, Su��a, Pol�nia, Benelux, Espanha e Escandin�via, e tamb�m E.U.A., Canad�, Brasil e Jap�o.',
    'A empresa disp�e actualmente de um dos maiores stocks de vinhos na Ilha da Madeira, constitu�do por vinhos de elevada qualidade, envelhecidos em cascos de carvalho, que lhe permitem dar resposta �s solicita��es dos mercados mais exigentes e selectivos.',
    tipo_valor_nt(),
    distribucion_exp_nt(),
    null
);

-- B_DO Entre bodega Justino's Madeira y la DO Madeira
insert into B_DO (id, fk_do_id, fk_do_variedadvid, fk_do_region, fk_bodega) values 
(8, 8, 7, 4, 4); 

-- TODO: Cambiar a Verdelho Coleita 1997 que gano el baccus de oro
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
    tipo_valor_nt(), -- TODO: 1999, 1998
    distribucion_exp_nt(), -- TODO: Conseguir o inventar datos de exportacion
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

-- Concurso de prueba
INSERT INTO Concurso VALUES (
    1,
    'Bacchus',
    DATOSDECONTACTO(
        conj_telefonos(34914293477, 34914291238), 
        null, 
        'info@uec.es', 
        'http://www.uec.es/',
        direccion('Madrid', '28014', 'C/ Lope de Vega, 27, Madrid, España', null),
        null
    ),
    'A ciegas',
    'N',
    premio_nt(),
    escala_nt(),
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

commit;