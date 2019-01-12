CREATE SEQUENCE seq_Ipais
 START WITH     1
 INCREMENT BY   1
 NOCACHE
 NOCYCLE
/
 CREATE SEQUENCE seq_Icontinente
 START WITH     1
 INCREMENT BY   1
 NOCACHE
 NOCYCLE
/
 CREATE SEQUENCE seq_Itiempo
 START WITH     1
 INCREMENT BY   1
 NOCACHE
 NOCYCLE
/
 CREATE SEQUENCE seq_Itipo_concurso
 START WITH     1
 INCREMENT BY   1
 NOCACHE
 NOCYCLE
/
 CREATE SEQUENCE seq_Imetricas_pais
 START WITH     1
 INCREMENT BY   1
 NOCACHE
 NOCYCLE
/
 CREATE SEQUENCE seq_Imetricas_concurso
 START WITH     1
 INCREMENT BY   1
 NOCACHE
 NOCYCLE
/

-- TODO: Despues de actualizar el modelo estrella, actualizar los create aqui 

create table I_metricas_pais (
    id number (10),
    id_tiempo number(10),
    id_lugar number(10),
    PorcentajeCrecimiento_prod number (3) not null,
    top1_productor_mundial varchar2(50) not null,
    top2_productor_mundial varchar2(50) not null,
    top3_productor_mundial varchar2(50) not null,
    top1_bodega_prod number not null,
    top2_bodega_prod number not null,
    top1_exportador varchar2(50) not null,
    top2_exportador varchar2(50) not null,
    top3_exportador varchar2(50) not null,
    top1_marcavino_totalprod varchar2(50) not null,
    top2_marcavino_totalprod varchar2(50) not null,
    top3_marcavino_totalprod varchar2(50) not null,
    top4_marcavino_totalprod varchar2(50) not null,
    top5_marcavino_totalprod varchar2(50) not null,
    top1_marcas_criticas varchar2(50) not null,
    top2_marcas_criticas varchar2(50) not null,
    top3_marcas_criticas varchar2(50) not null,
    constraint I_metricas_pais primary key (id)
)
/
create table I_metricas_concurso (
    id number (10),
    id_tipo_concurso number(10) not null,
    id_tiempo number(10),
    id_lugar number(10),
    PorcCrecimiento_TipoConcurso number(3) not null,
    top1_marca_premios varchar(50) not null,
    top2_marca_premios varchar(50) not null,
    top3_marca_premios varchar(50) not null,
    top1_catador varchar(50) not null,
    top2_catador varchar(50) not null,
    top3_catador varchar(50) not null,
    top_concursoCatadores varchar(50) not null,
    constraint I_metricas_concurso primary key (id)
)
/
create table I_tiempo (
    id number (10),
    anio date,
    bienio number (1) not null,
    constraint I_tiempo primary key (id)
)
/
create table I_pais (
    id number (10),
    id_continente number (10),
    nombre varchar(50) not null,
    fecha_creacion date not null,
    constraint I_pais primary key (id)
)
/
create table I_continente (
    id number (10),
    nombre varchar(50) not null,
    fecha_creacion date not null,
    constraint I_continente primary key (id)
)
/
create table I_tipo_concurso (
    id number (10),
    nombre varchar(50) not null,
    fecha_creacion date not null,
    constraint I_tipoConcurso primary key (id)
)
/

create table I_bodega (
    id number (10),
    anio number(10, 0) not null,
    nombre varchar(50) not null,
    produccion number (10) not null,
    exportacion number (10) not null,
    constraint I_bodega primary key (id)
)
/
create table I_marca (
    id number (10),
    anio number(10, 0) not null,
    nombre varchar(50) not null,
    produccion number (10) not null,
    exportacion number (10) not null,
    premios number not null,
    constraint I_marca primary key (id)
)
/
create table I_paisAux (
    id number (10),
    anio number(10, 0) not null,
    nombre varchar(50) not null,
    continente varchar(50) not null,
    produccion number (10) not null,
    exportacion number (10) not null,
    constraint I_paisAux primary key (id)
)
/
create table I_catador (
    id number (10),
    anio number(10, 0) not null,
    nombre varchar(50) not null,
    pasaporte number not null,
    premios number not null,
    constraint I_catador primary key (id)
)
/
create table I_concurso (
    id number (10),
    anio number(10, 0) not null,
    nombre varchar(50) not null,
    inscripciones number not null,
    tipoConcurso varchar(1) not null,
    constraint I_concurso primary key (id)
)
/
create table I_critica (
    id number (10),
    id_marca number (10),
    valor number not null,
    constraint I_critica primary key (id)
)
/
