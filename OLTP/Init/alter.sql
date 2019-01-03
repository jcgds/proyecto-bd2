ALTER SESSION SET CURRENT_SCHEMA=WINE_SCHEMA;

ALTER TABLE Region add constraint fk_region_pais foreign key (FK_Pais) references Pais (id);
alter table Bodega add constraint fk_bodega_bodega foreign key (propietario) references Bodega (id);

alter table DenominacionDeOrigen add (
    constraint fk_variedadvid_DO foreign key (FK_VariedadVid) references VariedadVid (id),
    constraint fk_region_DO foreign key (FK_Region) references Region (id)
);

ALTER TABLE B_DO add (
    constraint  fk_bdo_do FOREIGN KEY (fk_do_id, fk_do_VariedadVid, fk_do_region) REFERENCES DenominacionDeOrigen (id, FK_VariedadVid, FK_Region),
    constraint  fk_bdo_bodega FOREIGN KEY (fk_Bodega) REFERENCES Bodega (id)
);

alter table Cosecha add
    constraint fk_cosecha_bdo foreign key (fk_bdo_id, fk_bdo_do_id, fk_bdo_do_VariedadVid, fk_bdo_do_region, fk_bdo_bodega)
    references B_DO (id, fk_do_id, fk_do_VariedadVid, fk_do_region, fk_bodega);

ALTER TABLE CataAprendiz ADD CONSTRAINT fk_CA FOREIGN KEY (fk_catadoraprendiz)
    REFERENCES CatadorAprendiz (pasaporte);

ALTER TABLE CataAprendiz ADD CONSTRAINT fk_M FOREIGN KEY (fk_muestra_id, fk_muestra_marcavino_id,
                                                          fk_muestra_marcavino_clasif, fk_edicion, fk_catadorexperto)
    REFERENCES MuestraCatador (id, fk_marcavino_id, fk_marcavino_clasificacion, fk_edicion, fk_catadorexperto);

ALTER TABLE CataExperto ADD CONSTRAINT fk_CE FOREIGN KEY (fk_catadorexperto)
    REFERENCES CatadorExperto (id);

ALTER TABLE Juez ADD CONSTRAINT fk_Edicion_Juez FOREIGN KEY (fk_edicion)
    REFERENCES Edicion (id);

ALTER TABLE Juez ADD CONSTRAINT fk_CatadorExperto FOREIGN KEY (fk_catadorexperto)
    REFERENCES CatadorExperto (id);

ALTER TABLE Organizador_Concurso ADD CONSTRAINT fk_O FOREIGN KEY (fk_organizador)
    REFERENCES Organizador (id);

ALTER TABLE Organizador_Concurso ADD CONSTRAINT fk_Concurso FOREIGN KEY (fk_concurso)
    REFERENCES Concurso (id);

ALTER TABLE P_O ADD CONSTRAINT fk_Organizador FOREIGN KEY (fk_organizador)
    REFERENCES Organizador (id);

ALTER TABLE P_O ADD CONSTRAINT fk_Organizador_Pais FOREIGN KEY (fk_pais)
    REFERENCES Pais (id);

ALTER TABLE Edicion ADD CONSTRAINT fk_Concurso_Edicion FOREIGN KEY (fk_concurso)
    REFERENCES Concurso (id);

ALTER TABLE Inscripcion ADD CONSTRAINT fk_EI FOREIGN KEY (fk_edicion)
    REFERENCES Edicion(id);

ALTER TABLE Inscripcion ADD CONSTRAINT fk_CI FOREIGN KEY (fk_catadoraprendiz)
    REFERENCES CatadorAprendiz (pasaporte);

ALTER TABLE HistoricoPrecio ADD CONSTRAINT fk_histpre FOREIGN KEY (fk_presentacion, fk_marcavino,fk_clasificacionvinos)
    REFERENCES Presentacion (id, fk_marcavino,fk_clasificacionvinos);

ALTER TABLE Presentacion ADD CONSTRAINT fk_presentacion FOREIGN KEY (fk_marcavino, fk_clasificacionvinos)
    REFERENCES MarcaVino (id, fk_clasificacionvinos);

ALTER TABLE MarcaVino ADD CONSTRAINT fk_marcavino FOREIGN KEY (fk_clasificacionvinos)
    REFERENCES ClasificacionVinos (id);

ALTER TABLE ClasificacionVinos ADD CONSTRAINT fk_clasificacionvinos FOREIGN KEY (fk_clasificacionvinos)
    REFERENCES ClasificacionVinos (id);

ALTER TABLE MuestraCompite ADD CONSTRAINT fk_muestra_marca FOREIGN KEY (fk_marcavino, fk_clasificacionvinos)
    REFERENCES MarcaVino (id, fk_clasificacionvinos);

ALTER TABLE MuestraCompite ADD CONSTRAINT fk_muestra_inscripcion FOREIGN KEY (fk_inscripcion)
    REFERENCES Inscripcion (id);

ALTER TABLE MuestraCatador ADD CONSTRAINT fk_muestraCom_marca FOREIGN KEY (fk_marcavino_id, fk_marcavino_clasificacion)
    REFERENCES MarcaVino (id, fk_clasificacionvinos);

ALTER TABLE MuestraCatador ADD CONSTRAINT fk_muestraCom_juez FOREIGN KEY (fk_edicion, fk_catadorexperto)
    REFERENCES Juez (fk_edicion, fk_catadorexperto);

ALTER TABLE MarcaVino_B_DO ADD CONSTRAINT fk_MarcaBDO_marcavino FOREIGN KEY (fk_marcavino, fk_clasificacionvinos)
    REFERENCES MarcaVino (id, fk_clasificacionvinos);

ALTER TABLE MarcaVino_B_DO ADD CONSTRAINT fk_MarcaBDO_bdo FOREIGN KEY (fk_b_do, fk_bodega, fk_denominaciondeorigen,fk_do_VariedadVid,fk_do_region)
    REFERENCES B_DO (id, fk_bodega, fk_do_id,fk_do_VariedadVid,fk_do_region);

    ----------------- Alters de Data mart ----------------

    alter table DW_metricas_pais add (
    constraint fk_tiempo_Mpais foreign key (id_tiempo) references DW_tiempo (id),
    constraint fk_lugar_Mpais foreign key (id_lugar) references DW_pais (id)
);

alter table DW_metricas_concurso add (
    constraint fk_tiempo_Mconcurso foreign key (id_tiempo) references DW_tiempo (id),
    constraint fk_lugar_Mconcurso foreign key (id_lugar) references DW_pais (id),
    constraint fk_tipoConcurso_Mconcurso foreign key (id_tipo_concurso) references DW_tipo_concurso (id)
);

alter table DW_pais add (
    constraint fk_pais_Dcontinente foreign key (id_continente) references DW_continente (id)
);
