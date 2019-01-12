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

alter table I_critica add (
    constraint fk_critica_marca foreign key (id_marca) references I_marca (id)
);
