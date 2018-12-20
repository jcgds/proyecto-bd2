SET SERVEROUTPUT ON;
SET VERIFY OFF;


ACCEPT idCatadorAprendiz PROMPT 'Ingrese el pasaporte del catador aprendiz: ';
ACCEPT idMuestra PROMPT 'Ingrese el id de la muestra: ';
ACCEPT idMarca PROMPT 'Ingrese el id de la marca: ';
ACCEPT idEdicion PROMPT 'Ingrese el id de la edicion: ';
ACCEPT idCatadorExperto PROMPT 'Ingrese el id del CatadorExperto: ';

declare
    saveId number := ids_seq.nextval;
    clasifVino number;
    idMarcaa number := &idMarca;
begin

    select fk_clasificacionvinos into clasifVino
    from MarcaVino where id = idMarcaa;

    insert into CataAprendiz values (
        saveId,
        CURRENT_DATE,
        valoracion_nt(
            valoracion(null, 0, null)
        ),
        null,
        &idCatadorAprendiz,
        &idMuestra,
        idMarcaa,
        clasifVino,
        &idEdicion,
        &idCatadorExperto
    );

    DBMS_OUTPUT.PUT_LINE('Cata aprendiz registrada id: ' || to_char(saveId));
    DBMS_OUTPUT.PUT_LINE('Para insertar valoraciones utilizar @Procedures/insertar_valoracion_aprendiz');

end;
/

SET VERIFY ON;