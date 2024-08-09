/***
1. obtener base de cleitnes con su datos base para el reporte desde el amestro:
2. obtener los datso registrados en las ventas

 **/



/**********************************************/
CREATE OR REPLACE FORCE VIEW BOL_BI_COBERTURA_CLIE (EJERCICIO,V_MES, FECHA_FACTURA, REG,SUBREG,CLIENTE_ID,CLIENTE_NOMBRE,COD_RPN,GESTOR_VTAS,GESTOR_VTAS_N, CANALV, VE_PRM_CORP, NSKU_POP, NSKU_HER, NSKU_SUI, NSKU_GRU, NSKU_PRM, VE_POP,VE_HER,VE_SUI,VE_GRU,VE_PRM, CANTIDAD, IMP_NETO , UEN_POP, UEN_HER, UEN_SUI, UEN_GRU, UEN_PRM, UEN_CORPS) AS 
 SELECT /* query expandida de VENTAS COBERTURA CLIENTES */
    ejercicio,
    v_mes,
    fecha_factura,
    reg,
    subreg,
    cliente_id,
    cliente_nombre,
    gestor_vtas,
    gestor_vtas_n,
    canalv,
    count(distinct cliente_id) VE_PRM_CORP,
    COUNT(CASE WHEN uen = 'BOL - PROCAPS' THEN 1 END) AS NSKU_POP,
    COUNT(CASE WHEN uen = 'BOL - HERSIL SA' THEN 1 END) AS NSKU_HER,
    COUNT(CASE WHEN uen = 'BOL - SUIPHAR' THEN 1 END) AS NSKU_SUI,
    COUNT(CASE WHEN uen = 'BOL - GRUNENTHAL' THEN 1 END) AS NSKU_GRU,
    COUNT(CASE WHEN uen = 'BOL - PROMEDICAL' THEN 1 END) AS NSKU_PRM,
    AVG(CASE WHEN uen = 'BOL - PROCAPS' THEN 1 END) AS VE_POP,
    AVG(CASE WHEN uen = 'BOL - HERSIL SA' THEN 1 END) AS VE_HER,
    AVG(CASE WHEN uen = 'BOL - SUIPHAR' THEN 1 END) AS VE_SUI,
    AVG(CASE WHEN uen = 'BOL - GRUNENTHAL' THEN 1 END) AS VE_GRU,
    AVG(CASE WHEN uen = 'BOL - PROMEDICAL' THEN 1 END) AS VE_PRM,
    SUM(CANTIDAD) cantidad,
    SUM(IMP_NETO) IMP_NETO,
    MAX(CASE WHEN uen = 'BOL - PROCAPS' THEN uen END) AS UEN_POP,
    MAX(CASE WHEN uen = 'BOL - HERSIL SA' THEN uen END) AS UEN_HER,
    MAX(CASE WHEN uen = 'BOL - SUIPHAR' THEN uen END) AS UEN_SUI,
    MAX(CASE WHEN uen = 'BOL - GRUNENTHAL' THEN uen END) AS UEN_GRU,
    MAX(CASE WHEN uen = 'BOL - PROMEDICAL' THEN uen END) AS UEN_PRM,
    MAX(CASE WHEN FECHA_FACTURA IS NOT NULL THEN 'PROMEDICAL CORPS' END) UEN_CORPS
 FROM
    BOL_BI_VTAS_PPTO 
 WHERE
    ejercicio >= EXTRACT(YEAR FROM SYSDATE)-2
    AND codigo_articulo NOT IN (
        '00018653', '00018654', '00018656', '00027574', '00018812'
    )
    AND tipo_pedido BETWEEN '10' AND '16'
    and cantidad>0
     and FECHA_FACTURA BETWEEN to_Date('01/07/2024','DD/MM/YYYY') AND to_Date('28/07/2024','DD/MM/YYYY')
 GROUP BY
    ejercicio,
    v_mes,
    fecha_factura,
    reg,
    subreg,
    cliente_id,
    cliente_nombre,
    gestor_vtas,
    gestor_vtas_n,
    canalv

/**********************************************/
sum((CASE WHEN uen = 'BOL - PROCAPS' THEN 1 END))
DECODECASE WHEN uen = 'BOL - PROCAPS' THEN 1 END))


COLORES
DECODE(BOL_BI_COBERTURA_CLIE.GESTOR_VTAS_N, 'PAC-PATRICIA ARMINDA CHUQ', '0:ROJO')  
|7:AMARILLO

SUM(SELECT 1 FROM BOL_BI_VTAS_PPTO X
    WHERE X.ejercicio = bol_bi_vtas_ppto.ejercicio
    AND X.V_MES= bol_bi_vtas_ppto.v_mes AND X.cliente_id=bol_bi_vtas_ppto.cliente_id
    AND X.codigo_articulo NOT IN (
        '00018653', '00018654', '00018656','00027574','00018812'
    )
    AND X.tipo_pedido BETWEEN '10' AND '16'
    and X.cantidad>0 and X.uen in ('BOL - PROCAPS')
    group by x.ejercicio, x.v_mes,x.cliente_id
)

SUM(SELECT 1 C FROM BOL_BI_VTAS_PPTO X
    WHERE X.ejercicio = TO_NUMBER(bol_bi_vtas_ppto.ejercicio)
    AND X.V_MES= TO_NUMBER(bol_bi_vtas_ppto.v_mes) AND X.cliente_id=bol_bi_vtas_ppto.cliente_id
    AND X.codigo_articulo NOT IN (
        '00018653', '00018654', '00018656','00027574','00018812'
    )
    AND X.tipo_pedido BETWEEN '10' AND '16'
    and X.cantidad>0 and X.uen in ('BOL - PROCAPS')
    group by x.ejercicio, x.v_mes,x.cliente_id
)

select uen, UEN_AUX1 FROM /*query para obtener UEN */
    BOL_BI_VTAS_PPTO
 WHERE
    bol_bi_vtas_ppto.ejercicio IN (2024)
    AND bol_bi_vtas_ppto.v_mes = 07
 group by uen, UEN_AUX1

/**********************************************/


/**** mejorado por GEMINI */
WITH cte_uen AS (
  SELECT ejercicio, v_mes, cliente_id
         COUNT(CASE WHEN uen = 'BOL - PROCAPS' THEN 1 END) AS VE_POP,
         COUNT(CASE WHEN uen = 'BOL - HERSIL SA' THEN 1 END) AS VE_HER,
         COUNT(CASE WHEN uen = 'BOL - SUIPHAR' THEN 1 END) AS VE_SUI,
         COUNT(CASE WHEN uen = 'BOL - GRUNENTHAL' THEN 1 END) AS VE_GRU
  FROM bol_bi_vtas_ppto
  WHERE codigo_articulo NOT IN ('00018653', '00018654', '00018656', '00027574', '00018812')
    AND tipo_pedido BETWEEN '10' AND '16'
    AND cantidad > 0
  GROUP BY ejercicio, v_mes, cliente_id
)
SELECT
  b.ejercicio, b.v_mes, b.reg, b.subreg, b.cliente_id, b.cliente_nombre, b.cod_rpn,
  b.gestor_vtas, b.gestor_vtas_n, b.canalv, 1 AS v_efectiva,
  SUM(b.cantidad) AS cantidad, SUM(b.IMP_NETO) AS IMP_NETO,
  c.VE_POP, c.VE_HER, c.VE_SUI, c.VE_GRU
FROM bol_bi_vtas_ppto b
LEFT JOIN cte_uen c ON b.ejercicio = c.ejercicio AND b.v_mes = c.v_mes AND b.cliente_id = c.cliente_id
WHERE b.ejercicio = 2024
  AND b.v_mes = 07
  AND b.codigo_articulo NOT IN ('00018653', '00018654', '00018656', '00027574', '00018812')
  AND b.tipo_pedido BETWEEN '10' AND '16'
  AND b.cantidad > 0
GROUP BY
  b.ejercicio, b.v_mes, b.reg, b.subreg, b.cliente_id, b.cliente_nombre, b.cod_rpn,
  b.gestor_vtas, b.gestor_vtas_n, b.canalv, c.VE_POP, c.VE_HER, c.VE_SUI, c.VE_GRU



  TO_NUMBER(DECODE(SUM(b.PPTO_VLR), NULL, NULL, 0, 0, SUM(b.IMP_NETO) / SUM(b.PPTO_VLR) * 100)) AS cump,


select *
 FROM vistas_materializadas_cab_erp
 WHERE p.vista = user_objects.object_name)

/* para actualizar una vista materilizada */
begin
DBMS_MVIEW.REFRESH ('rhh_vm_personal_sit');
end;
/* para actualizar una vista materilizada */
SELECT *
FROM BOL_BI_COBERTURA_CLIE
WHERE V_MES =7


Ejemplo:

CREATE MATERIALIZED VIEW nombre_vm
...
REFRESH START WITH ROUND(SYSDATE + 1) + 9/24
NEXT NEXT_DAY(TRUNC(SYSDATE), 'TUESDAY') + 16/24
AS SELECT ...;
En caso del ejemplo, la base de datos Oracle refrescará automáticamente la vista materializada mañana a la 9:00 AM y posteriormente todos los martes a la 4:00 PM.

Publicad

/***** query PARA OBTENER DATOS AGENTES Y CODIGOS ADICIONALES ********/

gestor_vtas VARCHAR2(5),
    gestor_vtas_n VARCHAR2(30),

SELECT CODIGO, nombre, NIF, COUNT(*)
FROM AGENTES
WHERE EMPRESA ='004'
GROUP BY CODIGO, nombre,NIF 
HAVING COUNT(*)>2
/****************/

SELECT CODIGO FROM AGENTES WHERE EMPRESA ='004' AND NIF = GESTOR_VTAS

MAX(
  select  COUNT(*) from AGENTES_CLIENTES A
WHERE'040249' =A.AGENTE AND A.CODIGO_CLIENTE IN (SELECT C.CODIGO_RAPIDO FROM CLIENTES C WHERE C.codigo_empresa='004' AND C.FECHA_BAJA IS NULL )
)

=""

UPDATE 
'AAP','AKE','AMA','ANB','CCM','CHC','CLJ','CPT','DVP','ECD','EFV','ETJ','GGM','IAR','JBB','JPA','KRB','LGM','LOH','MAJ','MCL','NCP','PAC','PML','PSA','RAA','RBQ','YVS'
