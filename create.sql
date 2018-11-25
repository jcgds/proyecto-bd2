ALTER SESSION SET CURRENT_SCHEMA=WINE_SCHEMA;

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
    anio number(10),
    hechos varchar(100)
);
/
CREATE OR REPLACE TYPE unidadMonetaria as object (
    nombre varchar2(30),
    simbolo varchar2(10)
);
/
CREATE OR REPLACE TYPE valoracion_nt as TABLE OF valoracion;
/
CREATE OR REPLACE TYPE publicaciones_nt as TABLE OF varchar(50);
/
CREATE OR REPLACE TYPE hechos_hist_nt as TABLE OF hechos_hist;
/
-- TODO: Decidir size del varray
create or replace type conj_telefonos is varray(5) of number(14);
/
create or replace type direccion as object (
    estado varchar2(100),
    codigoPostal varchar2(15),
    lineaDireccion1 varchar2(100),
    lineaDireccion2 varchar2(100)
);
/
create or replace type personaDeContacto as object (
    nombre varchar2(50),
    apellido varchar2(50),
    cargo varchar2(50),
    email varchar2(50)
);
/
create or replace type personasDeContacto_nt as table of personaDeContacto;
/
create or replace type datosDeContacto as object (
    telefonos conj_telefonos,
    fax number(14),
    email varchar2(50),
    direccionWeb varchar2(100),
    dir direccion,
    personasDeContacto personasDeContacto_nt
);
/
create or replace type tipo_valor_nt as table of tipo_valor;
/
create or replace type distribucion_exp_nt as table of distribucion_exp;
/

CREATE OR REPLACE DIRECTORY mapas_regionales AS 'C:\WINE_DB\mapas_regionales';
/* Creacion de tablas */
-- Tablas Juan
CREATE TABLE Pais (
    id number,
    nombre varchar2(50) not null,
    continente varchar2(9) not null CHECK (continente IN ('Asia', 'Europa', 'África', 'América', 'Oceanía', 'Antártida')),
    superficieVinedo tipo_valor_nt,
    produccionAnual tipo_valor_nt,
    exportacionAnual distribucion_exp_nt,
    unidadMonetaria unidadMonetaria,
    mapaRegional BFILE,
    descripcion varchar2(200),
    constraint pk_pais primary key (id)
)
NESTED TABLE superficieVinedo STORE AS superficieVinedo_nt_pais,
NESTED TABLE produccionAnual STORE AS produccionAnual_nt_pais,
NESTED TABLE exportacionAnual STORE AS exportacionAnual_nt_pais;
/
create table Region (
    id number,
    nombre varchar2(50) not null,
    descripcion varchar2(100),
    FK_Pais number not null,
    constraint pk_region primary key (id)
);
/
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
    FK_VariedadVid number(10) not null,
    FK_Region number not null,
    constraint pk_denominacion_de_origen primary key (id, FK_VariedadVid, FK_Region)
);
/
create table Bodega (
    id number(10),
    nombre varchar2(50) not null,
    historia hechos_hist_nt,
    fechaFundacion date not null,
    datosDeContacto datosDeContacto,
    descripcionMision varchar2(200) not null,
    descripcionGeneralVinos varchar2(200) not null,
    produccionAnual tipo_valor_nt,
    exportacionAnual distribucion_exp_nt,
    propietario number,
    constraint pk_bodega primary key (id)
)
NESTED TABLE historia STORE AS historia_nt_bodega,
NESTED TABLE produccionAnual STORE AS produccionAnual_nt_bodega,
NESTED TABLE exportacionAnual STORE AS exportacionAnual_nt_bodega,
NESTED TABLE datosDeContacto.personasDeContacto STORE AS personasDeContacto_nt_bodega;
/

-- Tablas Cagua
/
CREATE TABLE CatadorAprendiz(
    pasaporte number,
    nombre varchar(50) NOT NULL,
    apellido varchar(50) NOT NULL,
    fechaDeNacimiento date NOT NULL,
    genero varchar(1) NOT NULL,
    lugarNacimiento lugar NOT NULL,
    CONSTRAINT tipo_genero CHECK (genero in ('M','F','O')),
    CONSTRAINT pk_catadoraprendiz PRIMARY KEY (pasaporte)
);
/
CREATE TABLE Cata (
    id number,
    fecha date NOT NULL,
    valoraciones valoracion_nt,
    fk_catadoraprendiz number,
    fk_catadorexperto number,
    fk_muestra number,
    CONSTRAINT pk_cata PRIMARY KEY (id)
)
NESTED TABLE valoraciones STORE AS valoracion_nt_1;
/
CREATE TABLE CatadorExperto (
    id number,
    nombre varchar(50) NOT NULL,
    apellido varchar(50) NOT NULL,
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
/* TODO: Faltan los contrainsts de Foreign key */
CREATE TABLE Jueces (
    id number,
    fk_catadorexperto number,
    fk_edicion number,
    CONSTRAINT pk_jueces PRIMARY KEY (id, fk_catadorexperto, fk_edicion)
);
/