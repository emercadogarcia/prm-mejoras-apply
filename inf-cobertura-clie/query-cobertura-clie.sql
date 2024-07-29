/***
1. obtener base de cleitnes con su datos base para el reporte desde el amestro:
2. obtener los datso registrados en las ventas

 **/

SELECT /* query original */
    SUBSTR(bol_bi_vtas_ppto.reg, 1, 7) c1,
    SUBSTR(bol_bi_vtas_ppto.subreg, 1, 7) c2,
    SUBSTR(bol_bi_vtas_ppto.canalv, 1, 20) c3,
    SUM(BOL_BI_VTAS_PPTO.CANTIDAD) n1,
    SUM(BOL_BI_VTAS_PPTO.IMP_NETO) n2,
    SUM(BOL_BI_VTAS_PPTO.PPTO_UND) n3,
    SUM(BOL_BI_VTAS_PPTO.PPTO_VLR) n4,
    TO_NUMBER(
        decode(
            SUM(BOL_BI_VTAS_PPTO.PPTO_VLR),
            null,
            null,
            0,
            0,
            SUM(BOL_BI_VTAS_PPTO.IMP_NETO) / SUM(BOL_BI_VTAS_PPTO.PPTO_VLR) * 100
        )
    ) n5,
    SUBSTR(bol_bi_vtas_ppto.rpn3, 1, 50) c4,
    SUBSTR(bol_bi_vtas_ppto.rpn4, 1, 50) c5,
    SUBSTR(bol_bi_vtas_ppto.rpn5, 1, 50) c6,
    SUBSTR(bol_bi_vtas_ppto.rpn6, 1, 50) c7,
    NULL gi$color
 FROM
    BOL_BI_VTAS_PPTO
 WHERE
    bol_bi_vtas_ppto.ejercicio IN (2024)
    AND bol_bi_vtas_ppto.v_mes = 07
    AND bol_bi_vtas_ppto.codigo_articulo NOT IN (
        '00018653',
        '00018654',
        '00018656',
        '00027574',
        '00018812'
    )
    AND bol_bi_vtas_ppto.tipo_pedido BETWEEN '10' AND '50'
 GROUP BY
    SUBSTR(bol_bi_vtas_ppto.reg, 1, 7),
    SUBSTR(bol_bi_vtas_ppto.subreg, 1, 7),
    SUBSTR(bol_bi_vtas_ppto.canalv, 1, 20),
    SUBSTR(bol_bi_vtas_ppto.rpn3, 1, 50),
    SUBSTR(bol_bi_vtas_ppto.rpn4, 1, 50),
    SUBSTR(bol_bi_vtas_ppto.rpn5, 1, 50),
    SUBSTR(bol_bi_vtas_ppto.rpn6, 1, 50)



/**********************************************/
CREATE OR REPLACE FORCE VIEW BOL_BI_COBERTURA_CLIE (EJERCICIO,V_MES, FECHA_FACTURA, REG,SUBREG,CLIENTE_ID,CLIENTE_NOMBRE,COD_RPN,GESTOR_VTAS,GESTOR_VTAS_N, CANALV,VE_PRM_CORP,NSKU_POP,NSKU_HER,NSKU_SUI,NSKU_GRU,VE_POP,VE_HER,VE_SUI,VE_GRU, CANTIDAD, IMP_NETO) AS 
 SELECT /* query expandida de VENTAS COBERTURA CLIENTES */
    ejercicio,
    v_mes,
    fecha_factura,
    reg,
    subreg,
    cliente_id,
    cliente_nombre,
    cod_rpn,
    gestor_vtas,
    gestor_vtas_n,
    canalv,
    1 ve_prm_CORP,
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
    SUM(IMP_NETO) IMP_NETO
 FROM
    BOL_BI_VTAS_PPTO 
 WHERE
    ejercicio >= EXTRACT(YEAR FROM SYSDATE)-2
    AND v_mes = 07
    AND codigo_articulo NOT IN (
        '00018653', '00018654', '00018656', '00027574', '00018812'
    )
    AND tipo_pedido BETWEEN '10' AND '16'
    and cantidad>0
     and FECHA_FACTURA BETWEEN to_Date('01/07/2024','DD/MM/YYYY') AND to_Date('25/07/2024','DD/MM/YYYY')
 GROUP BY
    ejercicio,
    v_mes,
    fecha_factura,
    reg,
    subreg,
    cliente_id,
    cliente_nombre,
    cod_rpn,
    gestor_vtas,
    gestor_vtas_n,
    canalv

/**********************************************/
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

