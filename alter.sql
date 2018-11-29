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
/
/*ALTER TABLE CataAprendiz ADD CONSTRAINT fk_M FOREIGN KEY (fk_muestra) 
    REFERENCES Muestra (id);*/

ALTER TABLE CataExperto ADD CONSTRAINT fk_CE FOREIGN KEY (fk_catadorexperto)
    REFERENCES CatadorExperto (id);
/
ALTER TABLE Juez ADD CONSTRAINT fk_Edicion_Juez FOREIGN KEY (fk_edicion)
    REFERENCES Edicion (id);
/
ALTER TABLE Juez ADD CONSTRAINT fk_CatadorExperto FOREIGN KEY (fk_catadorexperto)
    REFERENCES CatadorExperto (id);
/
ALTER TABLE Organizador_Concurso ADD CONSTRAINT fk_O FOREIGN KEY (fk_organizador)
    REFERENCES Organizador (id);
/
ALTER TABLE Organizador_Concurso ADD CONSTRAINT fk_Concurso FOREIGN KEY (fk_concurso)
    REFERENCES Concurso (id);
/
ALTER TABLE P_O ADD CONSTRAINT fk_Organizador FOREIGN KEY (fk_organizador)
    REFERENCES Organizador (id);
/
ALTER TABLE Edicion ADD CONSTRAINT fk_Concurso_Edicion FOREIGN KEY (fk_concurso)
    REFERENCES Concurso (id);
/
ALTER TABLE Inscripcion ADD CONSTRAINT fk_EI FOREIGN KEY (fk_edicion)
    REFERENCES Edicion(id);
/
ALTER TABLE Inscripcion ADD CONSTRAINT fk_CI FOREIGN KEY (fk_catadoraprendiz)
    REFERENCES CatadorAprendiz (pasaporte);
/    
