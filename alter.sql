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
ALTER TABLE HistoricoPrecio ADD CONSTRAINT fk_histpre FOREIGN KEY (fk_presentacion, fk_marcavino)
    REFERENCES Presentacion (id, fk_marcavino);
/
ALTER TABLE Presentacion ADD CONSTRAINT fk_presentacion FOREIGN KEY (fk_marcavino, fk_clasificacionvinos)
    REFERENCES MarcaVino (id, fk_clasificacionvinos);
/
ALTER TABLE MarcaVino ADD CONSTRAINT fk_marcavino FOREIGN KEY (fk_clasificacionvinos)
    REFERENCES ClasificacionVinos (id);
/
ALTER TABLE ClasificacionVinos ADD CONSTRAINT fk_clasificacionvinos FOREIGN KEY (fk_clasificacionvinos)
    REFERENCES ClasificacionVinos (id);
/
ALTER TABLE MuestraCompite ADD CONSTRAINT fk_muestra_marca FOREIGN KEY (fk_marcavino, fk_clasificacionvinos)
    REFERENCES MarcaVino (id, fk_clasificacionvinos);
/
ALTER TABLE MuestraCompite ADD CONSTRAINT fk_muestra_inscripcion FOREIGN KEY (fk_inscripcion)
    REFERENCES Inscripcion (id);
/
ALTER TABLE MuestraCatador ADD CONSTRAINT fk_muestraCom_marca FOREIGN KEY (fk_marcavino, fk_clasificacionvinos)
    REFERENCES MarcaVino (id, fk_clasificacionvinos);
/
ALTER TABLE MuestraCatador ADD CONSTRAINT fk_muestraCom_juez FOREIGN KEY (fk_juez, fk_edicion, fk_catadorexperto)
    REFERENCES Juez (id, fk_edicion, fk_catadorexperto);
/
ALTER TABLE MarcaVino_B_DO ADD CONSTRAINT fk_MarcaBDO_marcavino FOREIGN KEY (fk_marcavino, fk_clasificacionvinos)
    REFERENCES MarcaVino (id, fk_clasificacionvinos);
/
ALTER TABLE MarcaVino_B_DO ADD CONSTRAINT fk_MarcaBDO_bdo FOREIGN KEY (fk_b_do, fk_bodega, fk_denominaciondeorigen)
    REFERENCES MarcaVino (id, fk_bodega, fk_do_id);
