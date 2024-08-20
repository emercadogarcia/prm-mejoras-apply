SELECT ORGANIZACION_COMERCIAL,D_ORGANIZACION_COMERCIAL,ALMACEN,D_ALMACEN,CENTRO_CONTABLE,D_CENTRO_CONTABLE,TIPO_PEDIDO,D_TIPO_PEDIDO,TIPO_CLIENTE,D_TIPO_CLIENTE,AGENTE,D_AGENTE,SERIE_PRESUPUESTO,PRESUPUESTOS_EJE,SERIE_PEDIDO,PEDIDOS_EJE,SERIE_ALBARAN,ALBARANES_EJE,SERIE_FACTURA,SERIE_EFACTURA,FACTURAS_EJE,SERIE_ALBFAC,SERIE_FRA_SUST,SERIE_FRA_TRASLADO,CODIGO_INTERNO,EMPRESA FROM (SELECT PARAMETROS_SERIES_VENTAS.* ,(SELECT A.NOMBRE FROM AGENTES A WHERE A.CODIGO = PARAMETROS_SERIES_VENTAS.AGENTE AND A.EMPRESA = PARAMETROS_SERIES_VENTAS.EMPRESA) D_AGENTE,(SELECT nombre FROM almacenes WHERE almacen = parametros_series_ventas.almacen AND codigo_empresa = parametros_series_ventas.empresa) D_ALMACEN,(SELECT nombre FROM caracteres_asiento WHERE empresa = parametros_series_ventas.empresa AND codigo = parametros_series_ventas.centro_contable) D_CENTRO_CONTABLE,(SELECT descripcion FROM tipos_cliente WHERE codigo = parametros_series_ventas.tipo_cliente) D_TIPO_CLIENTE,(SELECT descripcion FROM tipos_pedido_vta WHERE  codigo_empresa = parametros_series_ventas.empresa AND organizacion_comercial = parametros_series_ventas.organizacion_comercial AND tipo_pedido = parametros_series_ventas.tipo_pedido) D_TIPO_PEDIDO,(SELECT nombre FROM organizacion_comercial WHERE codigo_org_comer = parametros_series_ventas.organizacion_comercial AND codigo_empresa = parametros_series_ventas.empresa) D_ORGANIZACION_COMERCIAL 
FROM PARAMETROS_SERIES_VENTAS)
 PARAMETROS_SERIES_VENTAS WHERE empresa = '004'
AND ('EMERCADO' = 'EMERCADO'
 OR (EXISTS (
 SELECT 1
 FROM org_comerc_usuarios u
 WHERE u.usuario = 'EMERCADO'
 AND u.organizacion_comercial = parametros_series_ventas.organizacion_comercial
 AND u.codigo_empresa = '004')
 AND (parametros_series_ventas.almacen IS NULL
 OR EXISTS (
 SELECT 1
 FROM almacenes_usuarios u
 WHERE u.usuario = 'EMERCADO'
 AND u.codigo_almacen = parametros_series_ventas.almacen
 AND u.codigo_empresa = '004'))))  order by ORGANIZACION_COMERCIAL, ALMACEN, TIPO_PEDIDO


 select empresa, organizacion_comercial,almacen, tipo_pedido, SERIE_ALBARAN, SERIE_FACTURA
  from PARAMETROS_SERIES_VENTAS 
  WHERE empresa = '004'
  and organizacion_comercial='04010'