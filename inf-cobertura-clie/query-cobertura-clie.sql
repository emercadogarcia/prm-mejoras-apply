/***
1. obtener base de cleitnes con su datos base para el reporte desde el amestro:
2. obtener los datso registrados en las ventas

 **/
SELECT
    C1,
    C2,
    C3,
    C4,
    C5,
    C6,
    C7,
    C8,
    C9,
    C10,
    C11,
    C12,
    C13,
    C14,
    C15,
    C16,
    C17,
    C18,
    C19,
    C20,
    C21,
    C22,
    C23,
    C24,
    C25,
    C26,
    C27,
    C28,
    C29,
    C30,
    C31,
    C32,
    C33,
    C34,
    C35,
    C36,
    C37,
    C38,
    C39,
    C40,
    C41,
    C42,
    C43,
    C44,
    C45,
    C46,
    C47,
    C48,
    C49,
    C50,
    N1,
    N2,
    N3,
    N4,
    N5,
    N6,
    N7,
    N8,
    N9,
    N10,
    N11,
    N12,
    N13,
    N14,
    N15,
    N16,
    N17,
    N18,
    N19,
    N20,
    N21,
    N22,
    N23,
    N24,
    N25,
    N26,
    N27,
    N28,
    N29,
    N30,
    N31,
    N32,
    N33,
    N34,
    N35,
    N36,
    N37,
    N38,
    N39,
    N40,
    N41,
    N42,
    N43,
    N44,
    N45,
    N46,
    N47,
    N48,
    N49,
    N50,
    TIPO,
    COLUMNA_RUPTURA,
    ALIAS_RUPTURA_C,
    ALIAS_RUPTURA_N,
    GI$COLOR
FROM
    (
        SELECT
            *
        FROM
            TABLE (
                pk_b2b_geninf.gi_obtener_registros_pipe ('004', 'EMERCADO', 'BOL_VTAS_PPTO_2', '23')
            )
    )
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
ORDER BY
    1,
    2


SELECT
    bol_bi_vtas_ppto.reg,
    bol_bi_vtas_ppto.subreg,
    bol_bi_vtas_ppto.cliente_id,
    bol_bi_vtas_ppto.cliente_nombre,
    bol_bi_vtas_ppto.cod_rpn,
    bol_bi_vtas_ppto.gestor_vtas,
    bol_bi_vtas_ppto.gestor_vtas_n,
    bol_bi_vtas_ppto.canalv,
    SUM(BOL_BI_VTAS_PPTO.CANTIDAD) cantidad,
    SUM(BOL_BI_VTAS_PPTO.IMP_NETO) IMP_NETO,
    SUM(BOL_BI_VTAS_PPTO.PPTO_UND) PPTO_UND,
    SUM(BOL_BI_VTAS_PPTO.PPTO_VLR) PPTO_VLR,
    TO_NUMBER(
        decode(
            SUM(BOL_BI_VTAS_PPTO.PPTO_VLR),
            null,
            null,
            0,
            0,
            SUM(BOL_BI_VTAS_PPTO.IMP_NETO) / SUM(BOL_BI_VTAS_PPTO.PPTO_VLR) * 100
        )
    ) cump
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
    bol_bi_vtas_ppto.reg,
    bol_bi_vtas_ppto.subreg,
    bol_bi_vtas_ppto.cliente_id,
    bol_bi_vtas_ppto.cliente_nombre,
    bol_bi_vtas_ppto.cod_rpn,
    bol_bi_vtas_ppto.gestor_vtas,
    bol_bi_vtas_ppto.gestor_vtas_n,
    bol_bi_vtas_ppto.canalv
ORDER BY
    12 DESC,
    13 DESC