CREATE TABLE bol_cobertura_clie_tmp
(
    ejercicio NUMBER,   
    v_mes NUMBER,
    reg VARCHAR2(5),
    subreg VARCHAR2(5),
    cliente_id VARCHAR2(8),
    cliente_nombre VARCHAR2(100),
    gestor_vtas VARCHAR2(5),
    gestor_vtas_n VARCHAR2(30),
    canalv VARCHAR2(20),
    ve_prm_corps NUMBER,  /* cambia nombre*/
    NSKU_POP NUMBER,
    NSKU_her NUMBER,
    NSKU_SUI NUMBER,
    NSKU_GRU NUMBER,
    NSKU_PRM NUMBER,
    VE_POP NUMBER,
    VE_HER NUMBER,
    VE_SUI NUMBER,
    VE_GRU NUMBER,
    VE_PRM NUMBER,
    usuario VARCHAR2(15),
    fecha_actulizado TIMESTAMP WITH TIME ZONE,
    AGENTE varchar2(15)
) 

select cliente_id, cliente_nombre, GESTOR
  from bol_cobertura_clie_tmp
 where condition

/******** insetamos los datos */
DELETE FROM bol_cobertura_clie_tmp WHERE USUARIO= :USUARIO  ;
COMMIT;
INSERT INTO bol_cobertura_clie_tmp (
    ejercicio,
    v_mes,
    reg,
    subreg,
    cliente_id,
    cliente_nombre,
    gestor_vtas,
    gestor_vtas_n,
    canalv,
    VE_PRM_CORPS, 
    NSKU_POP,
    NSKU_HER,
    NSKU_SUI,
    NSKU_GRU,
    NSKU_PRM,
    VE_POP,
    VE_HER,
    VE_SUI,
    VE_GRU,
    VE_PRM,
    USUARIO,
    FECHA_ACTULIZADO,
    AGENTE
)
SELECT
    ejercicio,
    v_mes,
    reg,
    subreg,
    cliente_id,
    cliente_nombre,
    gestor_vtas,
    gestor_vtas_n,
    canalv,
    COUNT(DISTINCT cliente_id) AS VE_PRM_CORPS, 
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
    :USUARIO AS USUARIO,
    CURRENT_DATE AS FECHA_ACTULIZADO,
    (SELECT MAX(CODIGO) FROM AGENTES WHERE EMPRESA ='004' AND FECHA_BAJA IS NULL AND NIF = GESTOR_VTAS) AS AGENTE
FROM
    BOL_BI_VTAS_PPTO
WHERE
    ejercicio >= EXTRACT(YEAR FROM SYSDATE) - 2
    AND codigo_articulo NOT IN ('00018653', '00018654', '00018656', '00027574', '00018812')
    AND tipo_pedido BETWEEN '10' AND '16'
    AND cantidad > 0
    AND FECHA_FACTURA BETWEEN to_Date(:F_FECHA_DESDE, 'DD/MM/YYYY') AND to_Date(:F_FECHA_HASTA, 'DD/MM/YYYY')
GROUP BY
    ejercicio,
    v_mes,
    reg,
    subreg,
    cliente_id,
    cliente_nombre,
    gestor_vtas,
    gestor_vtas_n,
    canalv;
COMMIT;


/****/