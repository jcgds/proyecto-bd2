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