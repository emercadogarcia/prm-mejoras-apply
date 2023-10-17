/* MEJORA PARA EL PPTO QUINCENAL PROMEDICAL SA*/

select ejercicio, v_mes, fuente, GESTOR_VTAS, tipo, TIPO_VTA
from ( /*se agrega codigo para generar datos de presupuesto quincenal */
SELECT null FECHA_FACTURA, v_xls_planes_ventas.ejercicio, SUBSTR(v_xls_planes_ventas.periodo,2) V_MES ,
     decode(CLIENTES.ZONA,'0410','SCZ','0420','LPZ','0430','CBBA','0440','TJA','0450','ALTO','0451','ALTO','0460','SCR','0461','SCR','0470','BENI','0471','BENI','SIN REG') REG
     , decode(CLIENTES.ZONA,'0410','SCZ','0420','LPZ','0430','CBBA','0440','TJA','0450','ALTO','0451','ORU','0460','SCR','0461','POT','0470','BENI','0471','PAN','SIN REG') SUBREG
     , clientes.canalv
     , clientes.cadena
     , clientes.RPN2
     , clientes.RPN3 /*nuevo campo adicionado*/
     , clientes.RPN4
     , clientes.RPN5
     , clientes.RPN6
     , DECODE(CLIENTES.CANALV,'DISTRIBUIDORES','DISTRIBUIDORES','ACCESO','ACCESO','INDEPENDIENTE','INDEPENDIENTE',CLIENTES.CADENA) CADENA_AUX
     , agentes_clientes.agente
     , agentes.nif                 COD_RPN
     , agentes.nombre              NOMBRE_AGENTE
     , v_xls_planes_ventas.cliente CLINETE_ID
     , clientes.razon_social       CLIENTE_NOMBRE
     , clientes.tipo_cliente       CAT_COD
     , ( SELECT REPLACE(tipos_cliente.descripcion,'CATEGOR�A ','')
         FROM TIPOS_CLIENTE
         WHERE tipos_cliente.codigo=CLIENTES.TIPO_CLIENTE
       ) CAT,
       (
       SELECT descripcion
       FROM familias
       WHERE codigo_familia     = articulos.codigo_estad5
              AND numero_tabla   = 5
              AND ultimo_nivel   = 'S'
              AND codigo_empresa = articulos.codigo_empresa
       ) UEN,
       articulos.codigo_estad5
     , articulos.codigo_estad3 LAB
     , v_xls_planes_ventas.articulo CODIGO_ARTICULO
     , articulos.descrip_comercial  ARTICULO_NOMBRE
     , articulos.codigo_estad2      JP_COD
     , (
              SELECT
                     descripcion
              FROM
                     familias
              WHERE
                     codigo_familia     = articulos.codigo_estad2
                     AND numero_tabla   = 2
                     AND ultimo_nivel   = 'S'
                     AND codigo_empresa = articulos.codigo_empresa
       ) JP_NOMBRE
     , articulos.codigo_estad4 ST_COD
     , (
              SELECT
                     descripcion
              FROM
                     familias
              WHERE
                     codigo_familia     = articulos.codigo_estad4
                     AND numero_tabla   = 4
                     AND ultimo_nivel   = 'S'
                     AND codigo_empresa = articulos.codigo_empresa
       ) ST_NOMBRE
     ,'11' tipo_pedido
     , agentes.usuario usuario_pedido
     , case
              when v_xls_planes_ventas.codigo in ('1464','1585')
                     then 'ÉTICO'
              when v_xls_planes_ventas.codigo in ('964')
                     then 'ENTIDADES'
                     ELSE 'SERVICIOS'
       END TIPO
     , case
              when v_xls_planes_ventas.codigo in ('1464','1585')
                     then 'ÉTICO'
              when v_xls_planes_ventas.codigo in ('964')
                     then 'ENTIDADES'
                     ELSE 'SERVICIOS'
       END  TIPO_VTA
     ,'PPTO Q'||SUBSTR(v_xls_planes_ventas.periodo,1,1) FUENTE, 0 CANTIDAD, 0 IMP_NETO, 0 IMP_FACTURADO
     , v_xls_planes_ventas.cantidad PPTO_UND
     , v_xls_planes_ventas.importe  PPTO_VLR
     , CASE
              when articulos.codigo_estad3 in ('HERSIL')
                THEN trim(subStr(clientes.RPN4,0,3))
              when articulos.codigo_estad3 in ('BIODUE','BONAPHARM')
                THEN trim(subStr(clientes.RPN2,0,3))
              when articulos.codigo_estad3 in ('LAFAGE')
                THEN trim(subStr(clientes.RPN3,0,3))
                else agentes.nif
         end GESTOR_VTAS
	   , V_XLS_PLANES_VENTAS.ALMACEN COD_ALMAC
FROM
       V_XLS_PLANES_VENTAS
     , (
        SELECT
             CLIENTES.*
            , (
                SELECT
                    NOMBRE
                FROM
                    VALORES_CLAVES V
                WHERE
                    V.CLAVE ='CANALV'
                    AND V.VALOR_CLAVE=
                     (
                       SELECT VALOR_CLAVE
                       FROM CLIENTES_CLAVES_ESTADISTICAS c
                       WHERE
                       c.CLAVE ='CANALV'
                       AND c.CODIGO_CLIENTE=clientes.codigo_rapido
                       AND c.CODIGO_EMPRESA=clientes.codigo_empresa
                       )
                ) CANALV
            , (
               SELECT  NOMBRE
                FROM VALORES_CLAVES V
                WHERE V.CLAVE ='CADN'
                    AND V.VALOR_CLAVE=
                    (
                            SELECT VALOR_CLAVE
                            FROM CLIENTES_CLAVES_ESTADISTICAS c
                            WHERE
                                 c.CLAVE             ='CADN'
                                 AND c.CODIGO_CLIENTE=CLIENTES.CODIGO_RAPIDO
                                 AND c.CODIGO_EMPRESA=CLIENTES.codigo_empresa
                            )
              ) CADENA
             , (
                            SELECT
                                   NOMBRE
                            FROM
                                   VALORES_CLAVES V
                            WHERE
                                   V.CLAVE          ='RPN2'
                                   AND V.VALOR_CLAVE=
                                   (
                                          SELECT
                                                 VALOR_CLAVE
                                          FROM
                                                 CLIENTES_CLAVES_ESTADISTICAS c
                                          WHERE
                                                 c.CLAVE             ='RPN2'
                                                 AND c.CODIGO_CLIENTE=clientes.codigo_rapido
                                                 AND c.CODIGO_EMPRESA=clientes.codigo_empresa
                                   )
                     ) RPN2
             , ( SELECT NOMBRE
                       FROM VALORES_CLAVES V
                       WHERE V.CLAVE ='RPN3' AND V.VALOR_CLAVE=
                            ( SELECT VALOR_CLAVE
                               FROM CLIENTES_CLAVES_ESTADISTICAS c
                               WHERE c.CLAVE ='RPN3'
                                  AND c.CODIGO_CLIENTE=clientes.codigo_rapido
                                  AND c.CODIGO_EMPRESA=clientes.codigo_empresa
                            )
              )   RPN3 /*nuevo campo*/
             , (
                    SELECT NOMBRE
                     FROM VALORES_CLAVES V
                     WHERE
                     V.CLAVE          ='RPN4'
                     AND V.VALOR_CLAVE=
                            (
                                  SELECT VALOR_CLAVE
                                   FROM CLIENTES_CLAVES_ESTADISTICAS c
                                   WHERE
                                   c.CLAVE             ='RPN4'
                                   AND c.CODIGO_CLIENTE=clientes.codigo_rapido
                                   AND c.CODIGO_EMPRESA=clientes.codigo_empresa
                                   )
                     ) RPN4
              , (
                     SELECT NOMBRE
                     FROM VALORES_CLAVES V
                     WHERE
                     V.CLAVE          ='RPN5'
                     AND V.VALOR_CLAVE=
                            (
                                  SELECT
                                          VALOR_CLAVE
                                   FROM
                                          CLIENTES_CLAVES_ESTADISTICAS c
                                   WHERE
                                          c.CLAVE             ='RPN5'
                                          AND c.CODIGO_CLIENTE=clientes.codigo_rapido
                                          AND c.CODIGO_EMPRESA=clientes.codigo_empresa
                                   )
                     )
                     RPN5
              , (
                     SELECT NOMBRE
                     FROM VALORES_CLAVES V
                     WHERE
                     V.CLAVE          ='RPN6'
                     AND V.VALOR_CLAVE=
                            (
                                   SELECT VALOR_CLAVE
                                   FROM CLIENTES_CLAVES_ESTADISTICAS c
                                   WHERE
                                   c.CLAVE             ='RPN6'
                                   AND c.CODIGO_CLIENTE=clientes.codigo_rapido
                                   AND c.CODIGO_EMPRESA=clientes.codigo_empresa
                                   )
                     )
                     RPN6
        FROM CLIENTES ) CLIENTES
     , AGENTES_CLIENTES
     , AGENTES
     , ARTICULOS
WHERE
       (
              V_XLS_PLANES_VENTAS.CLIENTE     =CLIENTES.CODIGO_RAPIDO
              and V_XLS_PLANES_VENTAS.EMPRESA =CLIENTES.CODIGO_EMPRESA
              and CLIENTES.CODIGO_RAPIDO      =AGENTES_CLIENTES.CODIGO_CLIENTE
              and CLIENTES.CODIGO_EMPRESA     =AGENTES_CLIENTES.EMPRESA
              and AGENTES.CODIGO              =AGENTES_CLIENTES.AGENTE
              and AGENTES.EMPRESA             =AGENTES_CLIENTES.EMPRESA
              and V_XLS_PLANES_VENTAS.EMPRESA =ARTICULOS.CODIGO_EMPRESA
              and V_XLS_PLANES_VENTAS.ARTICULO=ARTICULOS.CODIGO_ARTICULO
       )
       AND v_xls_planes_ventas.codigo IN ('1464','1585')
       AND v_xls_planes_ventas.empresa LIKE '004' 
/* codigo complementario. Dev = Edgar Mercado G.*/
) data
group by ejercicio, v_mes, fuente, GESTOR_VTAS, tipo, TIPO_VTA

