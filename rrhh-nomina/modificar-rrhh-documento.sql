

update rhh_personal
  set AUXILIAR = SUBSTR('RRHH' || :b1.dni,1,20)
WHERE GRUPO='0401' AND  Auxiliar is null and  dni= :b1.dni;

select *
from rhh_personal
where grupo = '0401'
and dni like '1919339'

/***************************************************/
select NUMERO_REGISTRO, DESCRIPCION
from CA_DOCUMENTOS
where NUMERO_REGISTRO LIKE '%191933%'
CA_DOCUMENTOS.NUMERO_REGISTRO

/***************************************************/
update CA_DOCUMENTOS
set NUMERO_REGISTRO='RRHH1919339'
where EMPRESA = '004' and  ORG_CALIDAD='11' 
and NUMERO_REGISTRO ='RRHH19193339'
/***************************************************/


