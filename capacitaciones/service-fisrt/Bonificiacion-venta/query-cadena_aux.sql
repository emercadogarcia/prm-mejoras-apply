/* se genera query para revision de cadena_aux */
SELECT
    codigo_rapido, nombre, razon_social, CANALV,  CADENA, cat, TNEGOCIO, 
    (SELECT NOMBRE FROM  VALORES_CLAVES V 
        WHERE  V.CLAVE = 'TNEG' AND V.VALOR_CLAVE = (
        SELECT
            VALOR_CLAVE
        FROM
            CLIENTES_CLAVES_ESTADISTICAS c
        WHERE
            c.CLAVE = 'TNEG'
            AND c.CODIGO_CLIENTE = CLIENTES.codigo_rapido
            AND c.CODIGO_EMPRESA = CLIENTES.codigo_empresa )
        ) CADENA_AUX
FROM
    (SELECT CLIENTES.*, (SELECT NOMBRE FROM  VALORES_CLAVES V 
    WHERE  V.CLAVE = 'CANALV' AND V.VALOR_CLAVE = (
        SELECT
            VALOR_CLAVE
        FROM
            CLIENTES_CLAVES_ESTADISTICAS c
        WHERE
            c.CLAVE = 'CANALV'
            AND c.CODIGO_CLIENTE = CLIENTES.codigo_rapido
            AND c.CODIGO_EMPRESA = CLIENTES.codigo_empresa )
        ) CANALV, 
    (SELECT NOMBRE FROM  VALORES_CLAVES V 
        WHERE  V.CLAVE = 'CADN' AND V.VALOR_CLAVE = (
        SELECT
            VALOR_CLAVE
        FROM
            CLIENTES_CLAVES_ESTADISTICAS c
        WHERE
            c.CLAVE = 'CADN'
            AND c.CODIGO_CLIENTE = CLIENTES.codigo_rapido
            AND c.CODIGO_EMPRESA = CLIENTES.codigo_empresa )
        ) CADENA, 
        (SELECT NOMBRE FROM  VALORES_CLAVES V 
        WHERE  V.CLAVE = 'TNEG' AND V.VALOR_CLAVE = (
        SELECT
            VALOR_CLAVE
        FROM
            CLIENTES_CLAVES_ESTADISTICAS c
        WHERE
            c.CLAVE = 'TNEG'
            AND c.CODIGO_CLIENTE = CLIENTES.codigo_rapido
            AND c.CODIGO_EMPRESA = CLIENTES.codigo_empresa )
        ) TNEGOCIO, 
        (SELECT REPLACE(tipos_cliente.descripcion,'CATEGORÍA ','')
          FROM TIPOS_CLIENTE
          WHERE tipos_cliente.codigo=CLIENTES.TIPO_CLIENTE
         ) CAT 
    FROM CLIENTES ) CLIENTES 
where
    codigo_empresa = '004'
    and fecha_baja is null AND ESTADO ='BOL'
    AND (CANALV IN ('INDEPENDIENTE') OR CADENA IN ('EMERGENTE') )





/*** CLAVES ESTADISICAS */
SELECT CLAVE,D_CLAVE,VALOR_CLAVE,D_VALOR_CLAVE,VALOR_NUMERICO,CODIGO_EMPRESA,CODIGO_CLIENTE,CLAVE_NUMERICA 
FROM (SELECT CLIENTES_CLAVES_ESTADISTICAS.* ,(SELECT NUMERICA FROM CLAVES_ESTADISTICAS C WHERE C.CLAVE = CLIENTES_CLAVES_ESTADISTICAS.CLAVE) CLAVE_NUMERICA,(SELECT lvce.nombre FROM claves_estadisticas lvce WHERE lvce.clave = clientes_claves_estadisticas.clave) D_CLAVE,(SELECT lvc.nombre FROM valores_claves lvc WHERE lvc.clave = clientes_claves_estadisticas.clave AND lvc.valor_clave = clientes_claves_estadisticas.valor_clave) D_VALOR_CLAVE FROM CLIENTES_CLAVES_ESTADISTICAS) CLIENTES_CLAVES_ESTADISTICAS WHERE (CODIGO_EMPRESA='004') and (CODIGO_CLIENTE='007030')


/***** MODIFICAR TINEG  POR CODIGO */

BEGIN
UPDATE clientes_claves_estadisticas SET VALOR_CLAVE='B19' 
WHERE CODIGO_EMPRESA='004' AND clave='TNEG' 
and CODIGO_CLIENTE IN ('022330','011611','011445','009206','009202','009201','009129','008701','008700','008076','008073','008072','008071'
);
COMMIT;
END;
    
    
    
    SELECT codigo_rapido
    FROM
    (SELECT CLIENTES.*, (SELECT NOMBRE FROM  VALORES_CLAVES V 
    WHERE  V.CLAVE = 'CANALV' AND V.VALOR_CLAVE = (
        SELECT
            VALOR_CLAVE
        FROM
            CLIENTES_CLAVES_ESTADISTICAS c
        WHERE
            c.CLAVE = 'CANALV'
            AND c.CODIGO_CLIENTE = CLIENTES.codigo_rapido
            AND c.CODIGO_EMPRESA = CLIENTES.codigo_empresa )
        ) CANALV, 
    (SELECT NOMBRE FROM  VALORES_CLAVES V 
        WHERE  V.CLAVE = 'CADN' AND V.VALOR_CLAVE = (
        SELECT
            VALOR_CLAVE
        FROM
            CLIENTES_CLAVES_ESTADISTICAS c
        WHERE
            c.CLAVE = 'CADN'
            AND c.CODIGO_CLIENTE = CLIENTES.codigo_rapido
            AND c.CODIGO_EMPRESA = CLIENTES.codigo_empresa )
        ) CADENA, 
        (SELECT NOMBRE FROM  VALORES_CLAVES V 
        WHERE  V.CLAVE = 'TNEG' AND V.VALOR_CLAVE = (
        SELECT
            VALOR_CLAVE
        FROM
            CLIENTES_CLAVES_ESTADISTICAS c
        WHERE
            c.CLAVE = 'TNEG'
            AND c.CODIGO_CLIENTE = CLIENTES.codigo_rapido
            AND c.CODIGO_EMPRESA = CLIENTES.codigo_empresa )
        ) TNEGOCIO, 
        (SELECT REPLACE(tipos_cliente.descripcion,'CATEGORÍA ','')
          FROM TIPOS_CLIENTE
          WHERE tipos_cliente.codigo=CLIENTES.TIPO_CLIENTE
         ) CAT 
    FROM CLIENTES ) CLIENTES 
where
    codigo_empresa = '004'
    and fecha_baja is null AND (CANALV IN ('LABORATORIO', 'EMPRESA') )

);
COMMIT;
END;

