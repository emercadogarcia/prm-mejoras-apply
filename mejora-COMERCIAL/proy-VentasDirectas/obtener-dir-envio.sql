/*** obtener la D_ZONA *****/
(
SELECT
    DESCRIPCION
FROM
    ZONAS Z
WHERE
    Z.CODIGO = DOMICILIOS_ENVIO.ZONA
    AND Z.EMPRESA = DOMICILIOS_ENVIO.EMPRESA
) 
D_ZONA,

/*****/

(SELECT d.nombre FROM domicilios_envio d WHERE d.numero_direccion = pedidos_ventas.domicilio_envio AND d.codigo_cliente = pedidos_ventas.cliente AND d.empresa = pedidos_ventas.empresa)

SELECT d.nombre, d.direccion, d.zona
FROM domicilios_envio d
WHERE d.codigo_cliente = '023977'
    and d.numero_direccion=
    AND d.empresa = '004'

/**** query obtener factira desde pedido */
SELECT DISTINCT f.numero_factura
FROM facturas_ventas f, albaran_ventas a, albaran_ventas_lin al, pedidos_ventas p 
WHERE p.empresa = '004' AND p.organizacion_comercial = '04010' 
AND p.numero_serie = '010' AND p.ejercicio = '2024' AND p.numero_pedido = '343' 
AND al.empresa(+) = p.empresa AND al.organizacion_comercial(+) = p.organizacion_comercial 
AND al.numero_serie_pedido(+) = p.numero_serie AND al.numero_pedido(+) = p.numero_pedido 
AND al.ejercicio_pedido(+) = p.ejercicio AND a.empresa = al.empresa 
AND a.organizacion_comercial = al.organizacion_comercial AND a.numero_serie = al.numero_serie 
AND a.numero_albaran = al.numero_albaran AND a.sub_albaran = al.sub_albaran 
AND a.ejercicio = al.ejercicio AND f.empresa(+) = a.empresa 
AND f.organizacion_comercial(+) = a.organizacion_comercial AND f.ejercicio(+) = a.ejercicio_factura 
AND f.numero_serie(+) = a.numero_serie_fra AND f.numero_factura(+) = a.numero_factura

/************************************************************/
/***** QUERY OBTIENE DATOA ALBARAN */
MAX((
    SELECT MAX(x.numero_albaran) from albaran_ventas_lin x where CRMEXPEDIENTES_CAB.ITEMA041=x.numero_serie_pedido and CRMEXPEDIENTES_CAB.ITEMN002=x.numero_pedido and CRMEXPEDIENTES_CAB.ITEMN001=x.ejercicio_pedido and CRMEXPEDIENTES_CAB.empresa=x.empresa
    ))

(
SELECT ZONA
FROM domicilios_envio de
WHERE de.codigo_cliente = CRMEXPEDIENTES_CAB.CODIGO_EMPRESA
    AND de.numero_direccion = pedidos_ventas.domicilio_envio
   AND de.empresa = pedidos_ventas.empresa
) ESTADO,

(SELECT ZONA
FROM domicilios_envio de
WHERE de.codigo_cliente = CRMEXPEDIENTES_CAB.CODIGO_EMPRESA
   AND de.EMPRESA = CRMEXPEDIENTES_CAB.empresa
   AND de.numero_direccion = (SELECT MAX(domicilio_envio) DOM FROM pedidos_ventas P
WHERE p.id_crm = (SELECT MAX(ID_DOCUMENTO) FROM crmexpedientes_documentos cd
WHERE cd.EMPRESA=p.empresa AND cd.numero_expediente = CRMEXPEDIENTES_CAB.NUMERO_EXPEDIENTE)
AND P.EMPRESA = CRMEXPEDIENTES_CAB.empresa))

max((SELECT ZONA
FROM domicilios_envio de
WHERE de.codigo_cliente = substr(CRMEXPEDIENTES_CAB.CODIGO_EMPRESA,2,6)
   AND de.EMPRESA = CRMEXPEDIENTES_CAB.empresa
   AND de.numero_direccion = (
SELECT max(domicilio_envio) d FROM pedidos_ventas P
WHERE p.id_crm in (SELECT ID_DOCUMENTO FROM crmexpedientes_documentos cd
WHERE cd.EMPRESA=p.empresa AND cd.numero_expediente = CRMEXPEDIENTES_CAB.NUMERO_EXPEDIENTE)
AND P.EMPRESA = CRMEXPEDIENTES_CAB.empresa
))
   )

((
SELECT max(domicilio_envio) d FROM pedidos_ventas P
WHERE p.id_crm in (SELECT ID_DOCUMENTO FROM crmexpedientes_documentos cd
WHERE cd.EMPRESA=p.empresa AND cd.numero_expediente = CRMEXPEDIENTES_CAB.NUMERO_EXPEDIENTE)
AND P.EMPRESA = CRMEXPEDIENTES_CAB.empresa
))

SELECT domicilio_envio FROM pedidos_ventas P
WHERE p.id_crm in (SELECT ID_DOCUMENTO FROM crmexpedientes_documentos cd
WHERE cd.EMPRESA=p.empresa AND cd.numero_expediente = CRMEXPEDIENTES_CAB.NUMERO_EXPEDIENTE)
AND P.EMPRESA = CRMEXPEDIENTES_CAB.empresa

/**-----------------------*****/
(
SELECT
    DESCRIPCION
FROM
    ZONAS Z
WHERE
    Z.CODIGO = CRMEXPEDIENTES_CAB.PED_DOM_ENV_REG
    AND Z.EMPRESA = CRMEXPEDIENTES_CAB.empresa
) 
/**-----------------------*****/
/**-----------------------*****/
SELECT domicilio_envio
FROM pedidos_ventas P
WHERE P.CLIENTE =CRMEXPEDIENTES_CAB.CODIGO_EMPRESA
 AND P.NUMERO_SERIE =CRMEXPEDIENTES_CAB.ITEMA041
 AND P.NUMERO_PEDIDO = CRMEXPEDIENTES_CAB.ITEMN002
 AND P.ejercicio = CRMEXPEDIENTES_CAB.ITEMN001
 AND P.EMPRESA = CRMEXPEDIENTES_CAB.empresa
 AND P.ORGANCIZACION_COMERCIAL ='04010'


/* extraer con el ID_CRM */
(SELECT numero_expediente FROM crmexpedientes_documentos WHERE EMPRESA='004' AND id_documento=pedidos_ventas.id_crm)

SELECT numero_expediente, ID_DOCUMENTO FROM crmexpedientes_documentos 
WHERE EMPRESA='004' AND numero_expediente = 733150
/************** correcto query **********/
SELECT ejercicio, numero_serie, numero_pedido, cliente, domicilio_envio
FROM pedidos_ventas P
WHERE p.id_crm = (SELECT ID_DOCUMENTO FROM crmexpedientes_documentos 
WHERE EMPRESA=p.empresa AND numero_expediente = 733150)
AND P.EMPRESA = '004'
/*********** fin query ******/

AND P.EMPRESA = CRMEXPEDIENTES_CAB.empresa
P.CLIENTE =CRMEXPEDIENTES_CAB.CODIGO_EMPRESA
 AND P.NUMERO_SERIE =CRMEXPEDIENTES_CAB.ITEMA041
 AND P.NUMERO_PEDIDO = CRMEXPEDIENTES_CAB.ITEMN002
 AND P.EJERCICI = CRMEXPEDIENTES_CAB.ITEMN001
 AND P.EMPRESA = CRMEXPEDIENTES_CAB.empresa
 AND P.ORGANCIZACION_COMERCIAL ='04010'


SELECT NUMERO_EXPEDIENTE, CODIGO_EMPRESA,EMPRESA,STATUS_EXPEDIENTE,status_interno,MOTIVO_DESCARTE,FECHA_FIN_PREVISTO,FECHA_FIN_REAL,SECUENCIA_INICIAL,USUARIO_CIERRE,usuario_alta,COMENTARIOS
  FROM CRMEXPEDIENTES_CAB
  WHERE EMPRESA='004' AND NUMERO_EXPEDIENTE = (SELECT numero_expediente FROM crmexpedientes_documentos WHERE EMPRESA='004' AND id_documento=pedidos_ventas.id_crm)
  /****  ****/ 


   (SELECT estado
                    FROM domicilios_envio de
                   WHERE     de.codigo_cliente = pedidos_ventas.cliente
                         AND de.numero_direccion =
                             pedidos_ventas.domicilio_envio
                         AND de.empresa = pedidos_ventas.empresa) ESTADO,