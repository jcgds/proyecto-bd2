ALTER SESSION SET CURRENT_SCHEMA=WINE_SCHEMA;

drop table test;

drop table VariedadVid cascade constraints purge;
drop table DenominacionDeOrigen cascade constraints purge;
drop table CatadorAprendiz cascade constraints purge;
drop table Cata cascade constraints purge;
drop table CatadorExperto cascade constraints purge;
drop table Jueces cascade constraints purge;
drop table Pais cascade constraints purge;
drop table Region cascade constraints purge;
drop table Bodega cascade constraints purge;
drop table B_DO cascade constraints purge;
drop table CataExperto cascade constraints purge;
drop table Concurso cascade constraints purge;
drop table Edicion cascade constraints purge;
drop table Inscripcion cascade constraints purge;
drop table Juez cascade constraints purge;
drop table Organizador cascade constraints purge;
drop table Organizador_Concurso cascade constraints purge;
drop table P_O cascade constraints purge;
drop table Cosecha cascade constraints purge;

drop type tipo_valor force;
drop type distribucion_exp force;
drop type valoracion force;
drop type lugar force;
drop type hechos_hist force;
drop type valoracion_nt force;
drop type publicaciones_nt force;
drop type conj_telefonos force;
drop type direccion force;
drop type personaDeContacto force;
drop type personasDeContacto_nt force;
drop type datosDeContacto force;
drop type tipo_valor_nt force;
drop type distribucion_exp_nt force;
