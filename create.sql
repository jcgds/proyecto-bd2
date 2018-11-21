/* Definicion de TDAs */

create or replace type tipo_valor as object (
    anio number(4, 0),
    valor number,
    unidad varchar(30)
);
/
create or replace type distribucion_exp as object (
    tipoValor tipo_valor,
    pais varchar2(50)
);
/
CREATE OR REPLACE TYPE valoracion as object (
    nombreElemento varchar(50),
    valor number,
    observacion varchar(100)
);
/
CREATE OR REPLACE TYPE lugar as object (
    ciudad varchar(50),
    pais varchar(50)
);
/
CREATE OR REPLACE TYPE hechos_hist as object (
    año number(10),
    hechos varchar(100)
);
/
CREATE OR REPLACE TYPE valoracion_nt as TABLE OF valoracion;
/
CREATE OR REPLACE TYPE publicaciones_nt as TABLE OF varchar(50);
/
CREATE OR REPLACE TYPE hechos_hist_nt as TABLE OF hechos_hist;
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
CREATE OR REPLACE TABLE CatadroAprendiz(
    pasaporte number,
    nombre varchar(50) NOT NULL,
    apellido varchar(50) NOT NULL,
    fechaDeNacimiento date NOT NULL,
    genero varchar(1) NOT NULL,
    lugarNacimiento lugar NOT NULL,
    CONSTRAINT tipo_genero CHECK (genero in ('M','F','O')),
    CONSTRAINT pk_catadoraprendiz PRIMARY KEY (id)
);
/
CREATE OR REPLACE TABLE Cata (
    id number,
    fecha date NOT NULL,
    valoraciones valoracion_nt
    fk_catadoraprendiz number,
    fk_catadorexperto number,
    fk_muestra number,
    CONSTRAINT pk_cata PRIMARY KEY (id)
)
NESTED TABLE valoraciones STORE AS valoracion_nt_1;
/
CREATE OR REPLACE TABLE CatadroExperto (
    id number,
    nombre varchar(50) NOT NULL,
    apellido varchar(50) NO NULL,
    fechaDeNacimiento date NOT NULL,
    descripcion varchar(100),
    hechosCurriculum hechos_hist_nt,
    lugarNacimiento lugar NOT NULL,
    publicaciones publicaciones_nt,
    genero varchar(1) NOT NULL,
    fk_pais number NOT NULL,
    CONSTRAINT tipo_genero_CE CHECK (genero in ('M','F','O')),
    CONSTRAINT pk_catadorexperto PRIMARY KEY (id)
)
NESTED TABLE hechosCurriculum STORE AS hechosCurriculum_nt_1
NESTED TABLE publicaciones STORE AS publicaciones_nt_1;
/
CREATE TABLE Jueces (
    id number,
    fk_catadorexperto number,
    fk_edicion number,
    CONSTRAINT pk_jueces PRIMARY KEY (id, fk_catadorexperto,fk_edicion)
);
/