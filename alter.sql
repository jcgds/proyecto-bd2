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