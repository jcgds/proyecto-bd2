SET SERVEROUTPUT ON;
ACCEPT idConcurso NUMBER PROMPT 'Introduzca el ID del concurso: ';

create or replace procedure validar_concurso as
    internacional varchar2(50);
    idC number := &idConcurso; 
begin
    
    internacional := validar_concurso_internacional(idC);
    DBMS_OUTPUT.PUT_LINE(internacional);
    
end;
/
execute validar_concurso();