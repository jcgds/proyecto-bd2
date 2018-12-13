CREATE OR REPLACE TRIGGER validar__jerarquia
BEFORE INSERT OR UPDATE OF nivel ON ClasificacionVinos
FOR EACH ROW
DECLARE
    nivelPadre clasificacionvinos.nivel%type;
BEGIN
    if :new.fk_clasificacionvinos is not null then
        select nivel into nivelPadre from ClasificacionVinos where id=:new.fk_clasificacionvinos;
        if nivelpadre <> :new.nivel - 1 then
            RAISE_APPLICATION_ERROR(-20001, 'Nivel invalido, deberia ser ' || TO_CHAR(nivelpadre + 1) || ' en vez de ' || TO_CHAR(:new.nivel));
        end if;
    else
        if :new.nivel <> 1 then
            RAISE_APPLICATION_ERROR(-20002, 'Si no tiene padre en la jerarquia su nivel deberia ser 1');
        end if;
    end if;
END;
/


CREATE OR REPLACE TRIGGER sumatoria_cataaprendiz
BEFORE INSERT OR UPDATE ON CataAprendiz
FOR EACH ROW
DECLARE
    suma number := 0;
    
BEGIN
    IF :NEW.valoraciones IS NOT NULL THEN
        FOR i IN :NEW.valoraciones.FIRST..:NEW.valoraciones.LAST LOOP
            suma := suma + :NEW.valoraciones(i).valor;
        END LOOP;
    END IF;

    :new.sumatoria := suma;
    
END; 
/

CREATE OR REPLACE TRIGGER sumatoria_cataexperto
BEFORE INSERT OR UPDATE ON CataExperto
FOR EACH ROW
DECLARE
    suma number := 0;
    
BEGIN
    IF :NEW.valoraciones IS NOT NULL THEN
        FOR i IN :NEW.valoraciones.FIRST..:NEW.valoraciones.LAST LOOP
            suma := suma + :NEW.valoraciones(i).valor;
        END LOOP;
    END IF;

    :new.sumatoria := suma;
    
END; 
/

CREATE OR REPLACE TRIGGER validar_inscripcion
BEFORE INSERT OR UPDATE ON Inscripcion 
FOR EACH ROW
DECLARE 
    esCatadores char(1);
BEGIN
    select C.deCatadores into esCatadores from Concurso C, Edicion E 
        where E.id = :new.fk_edicion and E.fk_concurso = C.id;

    IF :new.fk_bodega is not null then
        if esCatadores = 'S' then 
            RAISE_APPLICATION_ERROR(-20003, 'No se puede inscribir una bodega a un concurso de catadores');
        end if;
    elsif :new.fk_catadoraprendiz is not null then
        if esCatadores = 'N' then 
            RAISE_APPLICATION_ERROR(-20004, 'No se puede inscribir un catador a un concurso de bodegas');
        end if;
    elsif :new.fk_bodega is not null and :new.fk_catadoraprendiz is not null then
        RAISE_APPLICATION_ERROR(-20005, 'Una inscripcion no puede ser de una bodega y de un catador a la vez');
    end if; 
END;
/
 