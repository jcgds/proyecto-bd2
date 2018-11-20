/* Definicion de TDAs */

create or replace type tipo_valor as object (
    anio number(4, 0),
    valor number,
    unidad varchar2(30)
);
/
create or replace type distribucion_exp as object (
    tipoValor tipo_valor,
    pais varchar2(50)
);
/
/* Creacion de tablas */

create table VariedadVid (
    id number(10),
    nombre varchar2(50) not null,
    tipo varchar2(6) check (tipo in ('tinta','blanca')) not null,
    constraint pk_variedadvid primary key (id)
);
/
create table DenominacionDeOrigen (
    id number(10),
    nombre varchar2(50) not null,
    descripcion varchar2(250),
    FK_VariedadVid number(10),
    constraint fk_variedadvid_DO foreign key (FK_VariedadVid) references VariedadVid (id),
    constraint pk_denominacion_de_origen primary key (id, FK_VariedadVid)
);
/