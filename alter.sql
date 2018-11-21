ALTER TABLE Cata ADD CONSTRAINT fk_CA FOREIGN KEY (fk_catadoraprendiz) 
    REFERENCES CatadorAprendiz (pasaporte);

ALTER TABLE Cata ADD CONSTRAINT fk_CE FOREIGN KEY (fk_catadorexperto) 
    REFERENCES CatadorAprendiz (id);

    