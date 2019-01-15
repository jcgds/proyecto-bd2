-----------Consultas de las metricas de pais -----------------

------Produccion de cada pais -----
select p.nombre, SUM(t.valor) as produccion
    from Pais p CROSS JOIN TABLE (p.produccionAnual) t
    where t.anio = 2016
    group by p.nombre;
-------Exportacion de cada pais --------
select p.nombre, SUM(t.tipovalor.valor) as exportacion
    from Pais p CROSS JOIN TABLE (p.exportacionAnual) t
    where t.tipovalor.anio = 2016
    group by p.nombre;
------Produccion de cada bodega -----
    select b.nombre, SUM(t.valor) as produccion
        from Bodega b CROSS JOIN TABLE (b.produccionAnual) t
        where t.anio = 2016
        group by b.nombre;
------Produccion de cada marca -----
select m.nombre, SUM(t.valor) as produccion
    from MarcaVino m CROSS JOIN TABLE (m.produccionAnual) t
    where t.anio = 2016
    group by m.nombre;
------Criticas de cada marca -----
select m.nombre, t.valor.valor as puntaje
    from MarcaVino m CROSS JOIN TABLE (m.criticas) t
    where t.valor.anio = 2016
    order by m.nombre;
------Premios por marca -------------
select m.nombre, COUNT(*)
from muestraCompite c, marcaVino m, Inscripcion i
where c.premio is not empty and m.id = c.fk_marcavino and i.id = c.fk_inscripcion and EXTRACT(year from i.fecha) = 2018
group by m.nombre;
------Premios por catador -----------
select c.nombre, COUNT(*)
From CatadorAprendiz c, Inscripcion i
Where I.fk_catadoraprendiz = c.pasaporte and EXTRACT(year from i.fecha) = 2018 and i.premiocatador IS NOT NULL
group by c.nombre;
------Inscripciones por concurso--------


----- Porcentaje crecimiento produccion por pais -----------
select p.nombre, t.anio, t.bienio, mp.porcentajecrecimiento_prod
from i_metricas_pais mp, i_pais p, i_tiempo t
where  p.nombre = 'Portugal'
and mp.id_lugar = p.id
and t.id = mp.id_tiempo