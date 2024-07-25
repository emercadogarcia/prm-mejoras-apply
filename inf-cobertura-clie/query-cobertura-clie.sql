/***
1. obtener base de cleitnes con su datos base para el reporte desde el amestro:
2. obtener los datso registrados en las ventas

 **/

SELECT
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



SELECT /* query expandida  */
    bol_bi_vtas_ppto.ejercicio,
    bol_bi_vtas_ppto.v_mes,
    bol_bi_vtas_ppto.reg,
    bol_bi_vtas_ppto.subreg,
    bol_bi_vtas_ppto.cliente_id,
    bol_bi_vtas_ppto.cliente_nombre,
    bol_bi_vtas_ppto.cod_rpn,
    bol_bi_vtas_ppto.gestor_vtas,
    bol_bi_vtas_ppto.gestor_vtas_n,
    bol_bi_vtas_ppto.canalv,
    1 v_efectiva,
    SUM(BOL_BI_VTAS_PPTO.CANTIDAD) cantidad,
    SUM(BOL_BI_VTAS_PPTO.IMP_NETO) IMP_NETO,
    TO_NUMBER(
        decode(
            SUM(BOL_BI_VTAS_PPTO.PPTO_VLR),
            null,
            null,
            0,
            0,
            SUM(BOL_BI_VTAS_PPTO.IMP_NETO) / SUM(BOL_BI_VTAS_PPTO.PPTO_VLR) * 100
        )
    ) cump,
    (SELECT 1 v_efectiva FROM BOL_BI_VTAS_PPTO X
    WHERE X.ejercicio = bol_bi_vtas_ppto.ejercicio
    AND X.V_MES= bol_bi_vtas_ppto.v_mes AND X.cliente_id=bol_bi_vtas_ppto.cliente_id
    AND X.codigo_articulo NOT IN (
        '00018653', '00018654', '00018656','00027574','00018812'
    )
    AND X.tipo_pedido BETWEEN '10' AND '16'
    and X.cantidad>0 and X.uen in ('BOL - PROCAPS')
    group by x.ejercicio,x.v_mes,x.cliente_id) VE_POP 
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
    AND bol_bi_vtas_ppto.tipo_pedido BETWEEN '10' AND '16'
    and cantidad>0
GROUP BY
    bol_bi_vtas_ppto.ejercicio,
    bol_bi_vtas_ppto.v_mes,
    bol_bi_vtas_ppto.reg,
    bol_bi_vtas_ppto.subreg,
    bol_bi_vtas_ppto.cliente_id,
    bol_bi_vtas_ppto.cliente_nombre,
    bol_bi_vtas_ppto.cod_rpn,
    bol_bi_vtas_ppto.gestor_vtas,
    bol_bi_vtas_ppto.gestor_vtas_n,
    bol_bi_vtas_ppto.canalv


/**********************************************/
SELECT 1 v_efectiva FROM BOL_BI_VTAS_PPTO X
WHERE
    X.ejercicio = bol_bi_vtas_ppto.ejercicio
    AND X.V_MES= bol_bi_vtas_ppto.v_mes AND X.cliente_id=bol_bi_vtas_ppto.cliente_id
    AND X.codigo_articulo NOT IN (
        '00018653', '00018654', '00018656','00027574','00018812'
    )
    AND X.tipo_pedido BETWEEN '10' AND '16'
    and X.cantidad>0 and x.uen in ('BOL - PROCAPS')

select uen FROM
    BOL_BI_VTAS_PPTO
WHERE
    bol_bi_vtas_ppto.ejercicio IN (2024)
    AND bol_bi_vtas_ppto.v_mes = 07
group by uen

/**********************************************/

SELECT /* query resumida*/
    bol_bi_vtas_ppto.reg,
    bol_bi_vtas_ppto.subreg,
    bol_bi_vtas_ppto.cod_rpn,
    bol_bi_vtas_ppto.gestor_vtas,
    bol_bi_vtas_ppto.gestor_vtas_n,
    bol_bi_vtas_ppto.canalv,
    1 v_efectiva,
    COUNT(cliente_id) nro_clie,
    SUM(BOL_BI_VTAS_PPTO.CANTIDAD) cantidad,
    SUM(BOL_BI_VTAS_PPTO.IMP_NETO) IMP_NETO
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
    and cantidad>0
GROUP BY
    bol_bi_vtas_ppto.reg,
    bol_bi_vtas_ppto.subreg,
    bol_bi_vtas_ppto.cod_rpn,
    bol_bi_vtas_ppto.gestor_vtas,
    bol_bi_vtas_ppto.gestor_vtas_n,
    bol_bi_vtas_ppto.canalv 
    
 ORDER BY gestor_vtas_n
/* campos retirados
    bol_bi_vtas_ppto.cliente_id,
    bol_bi_vtas_ppto.cliente_nombre,
    bol_bi_vtas_ppto.cliente_id,
    bol_bi_vtas_ppto.cliente_nombre,
*/