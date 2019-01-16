-- Top 3 Paises por produccion 
select distinct mp.top1_productor_mundial || ' - Produccion: '|| x1.produccion "Posición 1", mp.top2_productor_mundial || ' - Produccion: '|| x2.produccion "Posición 2", mp.top3_productor_mundial || ' - Produccion: '|| x3.produccion "Posición 3"
from system.dw_tiempo t, system.dw_metricas_pais mp , (select produccion,nombre from system.i_paisaux where id_tiempoaux = :INP_ANIO_2) x1,(select produccion,nombre from system.i_paisaux where id_tiempoaux = :INP_ANIO_2) x2,
(select produccion,nombre from system.i_paisaux where id_tiempoaux = :INP_ANIO_2) x3
where t.anio = :INP_ANIO_2
and mp.id_tiempo = t.id and x1.nombre = mp.top1_productor_mundial and x2.nombre = mp.top2_productor_mundial and x3.nombre = mp.top3_productor_mundial
and (mp.top1_productor_mundial is not null
or mp.top2_productor_mundial is not null
or mp.top3_productor_mundial is not null)

-- Top 3 Paises por exportacion
select distinct mp.top1_exportador || ' - Exportacion: '|| x1.exportacion "Posición 1", mp.top2_exportador || ' - Exportacion: '|| x2.exportacion "Posición 2", mp.top3_exportador || ' - Exportacion: '|| x3.exportacion "Posición 3"
from system.dw_tiempo t, system.dw_metricas_pais mp , 
(select exportacion,nombre from system.i_paisaux where id_tiempoaux = :INP_ANIO_2) x1,
(select exportacion,nombre from system.i_paisaux where id_tiempoaux = :INP_ANIO_2) x2,
(select exportacion,nombre from system.i_paisaux where id_tiempoaux = :INP_ANIO_2) x3
where t.anio = :INP_ANIO_2
and mp.id_tiempo = t.id and x1.nombre = mp.top1_exportador and x2.nombre = mp.top2_exportador and x3.nombre = mp.top3_exportador
and (mp.top1_exportador is not null
or mp.top2_exportador is not null
or mp.top3_exportador is not null)

-- Top 5 Marcas de Vino por produccion por pais
select mp.top1_marcavino_totalprod "Posición 1", mp.top2_marcavino_totalprod "Posición 2", mp.top3_marcavino_totalprod "Posición 3", mp.top4_marcavino_totalprod "Posición 4", mp.top5_marcavino_totalprod "Posición 5"
from system.dw_metricas_pais mp, system.DW_Tiempo t, system.DW_Pais p
where t.anio = :INP_5_ANIO
and mp.id_tiempo = t.id
and p.nombre = :INP_5_PAIS
and p.id = mp.id_lugar
and (mp.top1_marcavino_totalprod is not null
or mp.top2_marcavino_totalprod is not null
or mp.top3_marcavino_totalprod is not null
or mp.top4_marcavino_totalprod is not null
or mp.top5_marcavino_totalprod is not null
)
and rownum <= 1

-- Top 5 Marcas de Vino por produccion por continente
select mp.top1_marcavino_totalprod "Posición 1", mp.top2_marcavino_totalprod "Posición 2", mp.top3_marcavino_totalprod "Posición 3", mp.top4_marcavino_totalprod "Posición 4", mp.top5_marcavino_totalprod "Posición 5"
from system.dw_metricas_pais mp, system.DW_Tiempo t
where t.anio = :INP_5_ANIO
and mp.id_tiempo = t.id
and mp.id_continente = :INP_5_CONT
and (mp.top1_marcavino_totalprod is not null
or mp.top2_marcavino_totalprod is not null
or mp.top3_marcavino_totalprod is not null
or mp.top4_marcavino_totalprod is not null
or mp.top5_marcavino_totalprod is not null
)
and rownum <= 1

-- Top 3 Marcas de vino por critica promedio y pais
select mp.top1_marcas_criticas ||  ' - Promedio de las criticas: '|| x1.valor "Posición 1", mp.top2_marcas_criticas || ' - Promedio de las criticas: '|| x2.valor "Posición 2", mp.top3_marcas_criticas || ' - Promedio de las criticas: '|| x3.valor "Posición 3"
from system.dw_metricas_pais mp, system.dw_pais p, system.dw_tiempo t, 
(select M.id, M.nombre, AVG(C.valor) as valor from system.i_marca M, system.i_bodega B, system.i_paisAux P, system.i_critica C where 
M.id_bodega = B.id and B.id_paisaux = P.id and P.id_tiempoaux = :INP_C_ANIO and P.nombre = :INP_C_PAIS and C.id_marca = M.id group by M.id,M.nombre) x1,
(select M.id, M.nombre, AVG(C.valor) as valor from system.i_marca M, system.i_bodega B, system.i_paisAux P, system.i_critica C where 
M.id_bodega = B.id and B.id_paisaux = P.id and P.id_tiempoaux = :INP_C_ANIO and P.nombre = :INP_C_PAIS and C.id_marca = M.id group by M.id,M.nombre) x2,
(select M.id, M.nombre, AVG(C.valor) as valor from system.i_marca M, system.i_bodega B, system.i_paisAux P, system.i_critica C where 
M.id_bodega = B.id and B.id_paisaux = P.id and P.id_tiempoaux = :INP_C_ANIO and P.nombre = :INP_C_PAIS and C.id_marca = M.id group by M.id,M.nombre) x3
where mp.top1_marcas_criticas is not null
and t.anio = :INP_C_ANIO
and mp.id_tiempo = t.id
and p.nombre = :INP_C_PAIS
and mp.id_lugar = p.id
and mp.top1_marcas_criticas = x1.nombre and mp.top2_marcas_criticas = x2.nombre and mp.top3_marcas_criticas = x3.nombre
and rownum <= 1

-- Top 3 Marcas de vino por premios ganados y pais
select mc.top1_marca_premios "Posición 1", mc.top2_marca_premios "Posición 2", mc.top3_marca_premios "Posición 3"
from system.dw_metricas_concurso mc, system.DW_Tiempo t, system.DW_Pais p
where mc.top1_marca_premios is not null
and t.anio = :INP_P_ANIO
and mc.id_tiempo = t.id
and p.nombre = :INP_P_PAIS
and mc.id_lugar = p.id
and rownum <= 1


-- Porcentaje de crecimiento por pais anual
select distinct t.anio as "Año", mp.porccrecimiento_prod_anual as "% Crecimiento", system.litros_a_hectolitros(paux.produccion) as "Producción (hl)"
from system.dw_metricas_pais mp, system.dw_pais p, system.dw_tiempo t, system.I_paisAux paux
where  p.nombre = :INP_NOMBRE_PAIS
and mp.id_lugar = p.id
and t.id = mp.id_tiempo
and paux.id_tiempoaux = t.anio
and paux.nombre = :INP_NOMBRE_PAIS
and mp.porccrecimiento_prod_anual is not null
order by t.anio asc

-- Porcentaje de crecimiento por pais bienio
select distinct to_char((select MIN(anio) from system.DW_Tiempo where bienio = t.bienio)) || '/' || to_char((select MAX(anio) from system.DW_Tiempo where bienio = t.bienio)) "Bienio", t.bienio "Número de Bienio",
mp.porccrecimiento_prod_bienio "% Crecimiento"
from system.dw_metricas_pais mp, system.dw_Pais p, system.dw_Tiempo t
where  p.nombre = :INP_NOMBRE_PAIS
and mp.id_lugar = p.id
and t.id = mp.id_tiempo
and mp.porccrecimiento_prod_bienio is not null
order by "Número de Bienio" asc

-- Concurso de catadores mas popular
select distinct mc.ConcursoMasPopular "Nombre", ic.inscripciones
from system.DW_metricas_concurso mc, system.DW_Tiempo t, system.I_Concurso ic
where t.anio = :INP_ANIO_P2
and mc.id_tiempo = t.id
and mc.concursomaspopular is not null
and ic.nombre = mc.concursomaspopular
and ic.id_tiempoaux = t.anio
and rownum <=1

-- Top 2 Bodegas produccion nacional
select mp.top1_bodega_prod "Posición 1", mp.top2_bodega_prod "Posición 2"
from system.dw_metricas_pais mp, system.DW_tiempo t, system.DW_Pais p
where mp.top1_bodega_prod is not null
and t.anio = :INP_BOD_ANIO
and mp.id_tiempo = t.id
and p.nombre = :INP_BOD_PAIS
and mp.id_lugar = p.id
and rownum <= 1


-- Otras de utilidad
-- Promedio de valor de criticas en un año para una marca
select AVG(c.valor)
from system.I_marca m, system.I_Critica c
where m.nombre = 'Reserva'
and m.id_tiempoaux = 2017
and c.id_marca = m.id