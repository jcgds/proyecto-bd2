CREATE ROLE Analista;
CREATE ROLE Productor;
CREATE ROLE Organizador;

GRANT CREATE SESSION TO Analista, Productor, Organizador;

GRANT SELECT ON I_Critica TO Analista, Productor;
GRANT SELECT ON I_Marca TO Analista, Productor;
GRANT SELECT ON I_Bodega TO Analista, Productor;
GRANT SELECT ON I_PaisAux TO Analista, Productor;
GRANT SELECT ON I_TiempoAux TO Analista, Organizador; 
GRANT SELECT ON I_Catador TO Analista, Organizador;
GRANT SELECT ON I_Concurso TO Analista, Organizador;

GRANT SELECT ON DW_Tiempo TO Analista, Productor, Organizador;
GRANT SELECT ON DW_Tipo_Concurso TO Analista, Organizador;
GRANT SELECT ON DW_Pais TO Analista, Productor, Organizador;
GRANT SELECT ON DW_Metricas_Concurso TO Analista, Organizador;
GRANT SELECT ON DW_Metricas_Pais TO Analista, Productor;

CREATE USER wine_admin IDENTIFIED BY admin123;
GRANT DBA TO wine_admin;

CREATE USER analista1 IDENTIFIED BY analista123;
GRANT Analista TO analista1;

CREATE USER productor1 IDENTIFIED BY productor123;
GRANT Productor TO productor1;

CREATE USER organizador1 IDENTIFIED BY organizador123;
GRANT Organizador TO organizador1;

CREATE USER ETT IDENTIFIED BY ett123;
GRANT CREATE SESSION TO ETT;
grant select any table, insert any table, delete any table, update any table to ETT; 
