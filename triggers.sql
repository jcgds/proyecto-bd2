CREATE OR REPLACE TRIGGER validar_jerarquia
BEFORE INSERT ON ClasificacionVinos
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

CREATE OR REPLACE TRIGGER validar_presentacion
BEFORE INSERT OR UPDATE OF tipo, unidadesEnCaja ON Presentacion
FOR EACH ROW
BEGIN
    if :new.unidadesEnCaja is not null and :new.tipo not like 'Caja' then
        RAISE_APPLICATION_ERROR(-20003, 'Para tener unidades en caja el tipo debe ser Caja');
    end if;
    
    if :new.unidadesEnCaja is null and :new.tipo not like 'Botella' then
        RAISE_APPLICATION_ERROR(-20004, 'Si no hay unidades en caja debe ser botella');
    end if;
END;
/

create or replace trigger validar_tipo_cata
before insert or update of tipoDeCata, deCatadores on Concurso
for each row
begin
    if :new.deCatadores like 'N' and :new.tipoDeCata like 'A ciegas' then
        RAISE_APPLICATION_ERROR(-20020, 'Los concursos ""A ciegas"" solo pueden ser de catadores.');
    end if;
end;
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