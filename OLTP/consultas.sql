-- Produccion de paises en un año
select p.nombre, WINE_SCHEMA.produccion_pais_en(p.id, 2016) prod
from Pais p
order by prod desc

-- Exportacion de paises en un año
select p.nombre, WINE_SCHEMA.CalcularExportacionPais(p.id, 2016) expt
from Pais p
order by expt desc

-- Marcas de vino con DO por bodega
select M.nombre "Vino", D.nombre "DO" from DenominacionDeOrigen D, MarcaVino M, MarcaVino_B_DO MB,Bodega B 
where B.id = MB.fk_bodega and M.id = MB.fk_marcavino and MB.fk_denominaciondeorigen = D.id and B.id = 1

-- Produccion por bodegas de un pais en un año
select null LINK, b.nombre LABEL, litros_a_hectolitros(produccion_bodega_en(b.id, :P30_ANIO)) VALUE
from Bodega b, B_DO bdo, Region r
where r.fk_pais = :P30_PAIS
and bdo.fk_do_region = r.id
and b.id = bdo.fk_bodega
group by b.id, b.nombre

-- Produccion de marcas de un pais en un año
select null link, mv.nombre label, litros_a_hectolitros(produccion_marca_en(mv.id, :P30_ANIO)) value
from Bodega b, B_DO bdo, Region r, MarcaVino mv, MarcaVino_B_DO mvbdo
where r.fk_pais = :P30_PAIS
and bdo.fk_do_region = r.id
and b.id = bdo.fk_bodega
and mvbdo.fk_b_do = bdo.id
and mvbdo.fk_bodega = b.id
and mvbdo.fk_denominaciondeorigen = bdo.fk_do_id
and mvbdo.fk_do_VariedadVid = bdo.fk_do_variedadvid
and mvbdo.fk_do_region = bdo.fk_do_region
and mv.id = mvbdo.fk_marcavino
and mv.fk_clasificacionvinos = mvbdo.fk_clasificacionvinos
group by mv.id, mv.nombre

-- Ganadores de una edicion de vinos
select bo.nombre Bodega, mv.nombre Vino, a.nombre Premio
from Bodega bo, MarcaVino mv, MuestraCompite mc, Inscripcion i, MarcaVino_B_DO mvbdo CROSS JOIN TABLE(mc.premio) a
where i.fk_edicion = :FC_EDICION
and mc.fk_inscripcion = i.id
and mv.id = mc.fk_marcavino
and mvbdo.fk_marcavino = mv.id
and bo.id = mvbdo.fk_bodega

-- Ganadores de una edicion de catadores
select ca.nombre || ' ' || ca.apellido Nombre, i.premioCatador Premio, pr.posicion
from CatadorAprendiz ca, Inscripcion i, Edicion e, Concurso c cross join table (c.premios) pr
where e.id = :FC_EDICION
and i.fk_edicion = e.id
and e.fk_concurso = c.id
and ca.pasaporte = i.fk_catadoraprendiz
and i.premioCatador is not null
and pr.nombre = i.premioCatador
order by pr.posicion asc

-- Premios de un concurso
select *
from the (select premios from concurso where id = :FC_CONCURSO)

-- Escalas de un concurso
select elemento, clasificacion, rangoinferior, rangosuperior 
from the (select escalas from concurso where id = :FC_CONCURSO)
order by elemento

-- Organizadores de un concurso
select o.nombre || ' ' || o.descripcion Nombre
from organizador o, organizador_concurso oc
where oc.fk_concurso = :FC_CONCURSO and oc.fk_organizador = o.id

-- Produccion anual por continente
select null, pt.nombre, litros_a_hectolitros(pt.produccion)
from (
    select pa.nombre, pa.continente, produccion_pais_en(pa.id, :P1_YEAR) produccion
    from Pais pa
    where continente = :P1_SELECT_CONTINENTE
    ) pt
order by pt.produccion desc

-- Bodegas por pais
select distinct bo.id, bo.nombre
from B_DO bdo, Pais p, Region r, DenominacionDeOrigen do, Bodega bo
where r.fk_pais = 1
and do.fk_region = r.id
and bdo.fk_do_id = do.id
and bdo.fk_do_region = do.fk_region
and bdo.fk_do_variedadvid = do.fk_variedadvid
and bdo.fk_bodega = bo.id