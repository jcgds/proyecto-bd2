ALTER SESSION SET CURRENT_SCHEMA=WINE_SCHEMA;

ALTER TABLE Region add constraint fk_region_pais foreign key (FK_Pais) references Pais (id);
alter table Bodega add constraint fk_bodega_bodega foreign key (propietario) references Bodega (id);

alter table DenominacionDeOrigen add (
    constraint fk_variedadvid_DO foreign key (FK_VariedadVid) references VariedadVid (id),
    constraint fk_region_DO foreign key (FK_Region) references Region (id)
);

ALTER TABLE Cata ADD CONSTRAINT fk_CA FOREIGN KEY (fk_catadoraprendiz) 
    REFERENCES CatadorAprendiz (pasaporte);

ALTER TABLE Cata ADD CONSTRAINT fk_CE FOREIGN KEY (fk_catadorexperto) 
    REFERENCES CatadorAprendiz (pasaporte);

