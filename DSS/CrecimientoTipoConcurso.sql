create or replace procedure TransformarCrecimientoConcurso as
inscripcionAnualInicial number;
inscripcionAnualInicialB number;
inscripcionAnualFinal number;
inscripcionAnualFinalB number;
porcentajeAnual number;
porcentajeBienio number;
porcentajeAnualB number;
porcentajeBienioB number;
idConcursoHolder number;
InsC number;
InsB number;
existe number;
idC number;
idB number;
begin

    Select count(*) into existe from I_tipo_concurso where nombre = 'S';
    if existe = 0 then
        insert into I_tipo_concurso values (seq_Itipo_concurso.nextval, 'S', SYSDATE);
    end if;
    existe:=0;
    Select count(*) into existe from I_tipo_concurso where nombre = 'N';
    if existe = 0 then
        insert into I_tipo_concurso values (seq_Itipo_concurso.nextval, 'N', SYSDATE);
    end if;
    Select id into idC from I_tipo_concurso where nombre = 'S';
    Select id into idB from I_tipo_concurso where nombre = 'N';

    -- Recorremos los años y bienos que debieron ser previamente calculados
    -- con el procedimiento TransformarTiempo
    << time_loop >>
    for recTiempo in (
        select id, anio, bienio
        from i_tiempo
        order by anio asc, bienio asc
    ) loop

        inscripcionAnualInicial := Inscripciones_en_anio(recTiempo.anio-1, 'S');
        inscripcionAnualFinal := Inscripciones_en_anio(recTiempo.anio, 'S');
        inscripcionAnualInicialB := Inscripciones_en_anio(recTiempo.anio-1, 'N');
        inscripcionAnualFinalB := Inscripciones_en_anio(recTiempo.anio, 'N');

        if InscripcionAnualInicial = 0 then
            porcentajeAnual := null;
        else
            porcentajeAnual := variacion(inscripcionAnualInicial,inscripcionAnualFinal);
        end if;

        if InscripcionAnualInicialB = 0 then
            porcentajeAnualB := null;
        else
            porcentajeAnualB := variacion(inscripcionAnualInicialB,inscripcionAnualFinalB);
        end if;

        porcentajeBienio := variacion(
                inscripciones_en_bienio(recTiempo.bienio-1, 'S'),
                inscripciones_en_bienio(recTiempo.bienio, 'S')
            );

        porcentajeBienioB := variacion(
                inscripciones_en_bienio(recTiempo.bienio-1, 'N'),
                inscripciones_en_bienio(recTiempo.bienio, 'N')
            );

        insert into I_metricas_concurso (id, id_tipo_concurso, id_tiempo, porcencrecimiento_tipoConcurso, PorcCrecimiento_tipo_bienio) values (seq_Imetricas_concurso.nextval, idC, recTiempo.id, porcentajeAnual, porcentajeBienio);
        insert into I_metricas_concurso (id, id_tipo_concurso, id_tiempo, porcencrecimiento_tipoConcurso, PorcCrecimiento_tipo_bienio) values (seq_Imetricas_concurso.nextval, idB, recTiempo.id, porcentajeAnualB, porcentajeBienioB);

    end loop time_loop;

end;

create or replace function Inscripciones_en_anio(anio number, tipo varchar2) return number is
InscripcionN number;
begin

     select SUM(Inscripciones) into InscripcionN from I_Concurso where tipoConcurso = tipo and id_tiempoAux = anio;
     if inscripcionN IS NULL then
        return 0;
     end if;
    return InscripcionN;
end;

create or replace function Inscripciones_en_bienio(p_bienio number, tipo varchar2) return number is
anio1 number;
anio2 number;
begin

    select MIN(anio) into anio1 from I_Tiempo where bienio = p_bienio;
    anio2 := anio1 + 1;

    return inscripciones_en_anio(anio1, tipo) + Inscripciones_en_anio(anio2, tipo);
end;
