-- Top 5 Marcas de Vino por produccion por pais
select mp.top1_marcavino_totalprod, mp.top2_marcavino_totalprod, mp.top3_marcavino_totalprod, mp.top4_marcavino_totalprod, mp.top5_marcavino_totalprod
from system.dw_metricas_pais mp, system.DW_Tiempo t, system.DW_Pais p
where t.anio = :INP_ANIO_4
and mp.id_tiempo = t.id
and p.nombre = :INP_NOMBRE_PAIS_2
and p.id = mp.id_lugar
and (mp.top1_marcavino_totalprod is not null
or mp.top2_marcavino_totalprod is not null
or mp.top3_marcavino_totalprod is not null
or mp.top4_marcavino_totalprod is not null
or mp.top5_marcavino_totalprod is not null
)
and rownum <= 1

-- Top 5 Marcas de Vino por produccion por continente
select mp.top1_marcavino_totalprod, mp.top2_marcavino_totalprod, mp.top3_marcavino_totalprod, mp.top4_marcavino_totalprod, mp.top5_marcavino_totalprod
from system.dw_metricas_pais mp, system.DW_Tiempo t
where t.anio = :INP_ANIO_4
and mp.id_tiempo = t.id
and mp.id_continente = 72
and (mp.top1_marcavino_totalprod is not null
or mp.top2_marcavino_totalprod is not null
or mp.top3_marcavino_totalprod is not null
or mp.top4_marcavino_totalprod is not null
or mp.top5_marcavino_totalprod is not null
)
and rownum <= 1

-- Top 3 Marcas de vino por critica promedio y pais
select mp.top1_marcas_criticas, mp.top2_marcas_criticas, mp.top3_marcas_criticas
from system.dw_metricas_pais mp, system.dw_pais p, system.dw_tiempo t
where mp.top1_marcas_criticas is not null
and t.anio = :INP_C_ANIO
and mp.id_tiempo = t.id
and p.nombre = :INP_C_PAIS
and mp.id_lugar = p.id
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


-- Otras de utilidad
-- Promedio de valor de criticas en un año para una marca
select AVG(c.valor)
from system.I_marca m, system.I_Critica c
where m.nombre = 'Reserva'
and m.id_tiempoaux = 2017
and c.id_marca = m.id