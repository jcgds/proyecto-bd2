    alter table DW_metricas_pais add (
    constraint fk_tiempo_Mpais foreign key (id_tiempo) references DW_tiempo (id),
    constraint fk_lugar_Mpais foreign key (id_lugar) references DW_pais (id)
);

alter table DW_metricas_concurso add (
    constraint fk_tiempo_Mconcurso foreign key (id_tiempo) references DW_tiempo (id),
    constraint fk_lugar_Mconcurso foreign key (id_lugar) references DW_pais (id),
    constraint fk_tipoConcurso_Mconcurso foreign key (id_tipo_concurso) references DW_tipo_concurso (id)
);
