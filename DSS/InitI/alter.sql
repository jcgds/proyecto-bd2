alter table I_metricas_pais add (
    constraint fk_tiempo_IMpais foreign key (id_tiempo) references I_tiempo (id),
    constraint fk_lugar_IMpais foreign key (id_lugar) references I_pais (id)
);

alter table I_metricas_concurso add (
    constraint fk_tiempo_IMconcurso foreign key (id_tiempo) references I_tiempo (id),
    constraint fk_lugar_IMconcurso foreign key (id_lugar) references I_pais (id),
    constraint fk_tipoConcurso_IMconcurso foreign key (id_tipo_concurso) references I_tipo_concurso (id)
);

alter table I_pais add (
    constraint fk_pais_IDcontinente foreign key (id_continente) references I_continente (id)
);

alter table I_paisAux add (
    constraint fk_pais_tiempoAux foreign key (id_tiempoAux) references I_tiempoAux (anio)
);

alter table I_bodega add (
    constraint fk_bodega_tiempoAux foreign key (id_tiempoAux) references I_tiempoAux (anio)
);

alter table I_bodega add (
    constraint fk_bodega_paisAux foreign key (id_paisAux) references I_paisAux (id)
);

alter table I_marca add (
    constraint fk_marca_tiempoAux foreign key (id_tiempoAux) references I_tiempoAux (anio)
);

alter table I_marca add (
    constraint fk_marca_bodega foreign key (id_bodega) references I_bodega (id)
);

alter table I_catador add (
    constraint fk_catador_tiempoAux foreign key (id_tiempoAux) references I_tiempoAux (anio)
);

alter table I_concurso add (
    constraint fk_concurso_tiempoAux foreign key (id_tiempoAux) references I_tiempoAux (anio)
);

alter table I_critica add (
    constraint fk_critica_marca foreign key (id_marca) references I_marca (id)
);
