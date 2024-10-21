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



/***********************/
select *
FROM CLIENTES 
WHERE codigo_empresa in ('004','999') 
and codigo_rapido in ('011834' ,'023970', '0239')
BETWEEN '011834' and '023970'
and nombre like 'CLIENTE %'
and codigo_rapido in ('023901', '023807','023905', '003128')



*********
pusuario: EMERCADO, pfecha_proceso: 20/08/2024, pcontador: 1, pmensaje: Error al cantabilizar MAL, pfuncion: PKFAGENFACTU, porigen: GCF

PILA: PKFAGENFACTU.FACTURAR(5193) \ 
PKFAGENFACTU.GENERAR_FACTURAS(6523) \ 
PKMENGENFACT.INSERTAR_ERROR(14)


SELECT fv.ROWID rowid_fac, fv.empresa,fv.ejercicio,fv.numero_serie,fv.numero_factura,fv.tipo_factura,fv.organizacion_comercial,fv.cliente,to_char(fv.fecha_factura,'dd/mm/yyyy') fecha_factura,DECODE ('','C', NVL('',TO_CHAR(fv.fecha_contabilizacion,'DD/MM/YYYY')) ,DECODE ('', 'B', '',DECODE (fv.fecha_contabilizacion, NULL, '', to_char(fv.fecha_contabilizacion, 'dd/mm/yyyy')))) fecha_contabilizacion,to_char(fv.fecha_contabilizacion, 'dd/mm/yyyy') fecha_contabilizacion_ori,fv.codigo_divisa, fv.forma_cobro, fv.centro_contable,fv.dtos_global, fv.imp_dto_global, fv.imp_dto_global_div, fv.dto_pronto_pago, fv.recargo_financiero,fv.imp_dto_pronto_pago, fv.imp_dto_pronto_pago_div, fv.imp_recargo_financiero, fv.imp_recargo_financiero_div, fv.imp_fac_bruto, fv.imp_fac_dto1, fv.imp_fac_dto2,fv.imp_fac_dto3, fv.imp_fac_dto4, fv.imp_fac_dto5, fv.imp_fac_dto6, fv.imp_fac_dto7, fv.imp_fac_dto8, fv.imp_fac_dto9, fv.importe_fac_neto, fv.liquido_factura, fv.imp_fac_bruto_div,fv.imp_fac_dto1_div, fv.imp_fac_dto2_div, fv.imp_fac_dto3_div, fv.imp_fac_dto4_div, fv.imp_fac_dto5_div, fv.imp_fac_dto6_div, fv.imp_fac_dto7_div, fv.imp_fac_dto8_div,fv.imp_fac_dto9_div, fv.imp_recargo_2_div, fv.imp_recargo_3_div, fv.importe_fac_neto_div, fv.liquido_factura_div, fv.numero_asiento_borrador, fv.usuario, fv.numero_dua, to_char(fv.fecha_dua, 'dd/mm/yyyy'),fv.identicket, fv.observaciones, fv.status_factura, fv.coste_bruto, fv.dcto_tipo_pedido, fv.imp_dcto_tipo_pedido, fv.imp_dcto_tipo_pedido_div, fv.importe_anticipo,fv.importe_anticipo_div, fv.imp_dto_global_iva, fv.imp_dto_global_iva_div, fv.imp_dto_tpedido_iva, fv.imp_dto_tpedido_iva_div, fv.imp_dto_ppago_iva, fv.imp_dto_ppago_iva_div,fv.albaran_factura, fv.total_pto_verde, fv.total_pto_verde_div, fv.numero_obra, fv.serie_oferta, fv.numero_oferta, to_char(fv.fecha_impresion, 'dd/mm/yyyy hh24:mi:ss'), numero_asiento_anulado, fecha_asiento_anulado, diario_anulado, referencia_cobro 
FROM facturas_ventas fv, rango_series_ventas rs where 1=1 AND fv.empresa = rs.empresa(+) AND fv.numero_serie = rs.numero_serie(+) AND (fv.numero_factura BETWEEN rs.desde_numero AND rs.hasta_numero OR rs.desde_numero IS NULL) AND (fv.fecha_factura <= rs.fecha_validez OR rs.fecha_validez IS NULL) and fv.numero_serie = '210' and fv.numero_factura = 17 and fv.fecha_factura = to_date('20/08/2024', 'dd/mm/yyyy') and fv.usuario = 'EMERCADO' AND fv.empresa = '004' 
AND (fv.numero_asiento_borrador IS NULL OR pkconbloqueo.anulado(fv.empresa, fv.diario, fv.fecha_contabilizacion, fv.numero_asiento_borrador)='S') AND fv.organizacion_comercial = '04010' 
AND EXISTS (SELECT 1 FROM albaran_ventas WHERE albaran_ventas.empresa = fv.empresa AND albaran_ventas.numero_factura = fv.numero_factura AND albaran_ventas.numero_serie_fra = fv.numero_serie AND albaran_ventas.ejercicio_factura = fv.ejercicio and albaran_ventas.anulado = 'N') and not exists (select 1 from facturas_ventas_anticipos fva, facturas_ventas fv2  where fva.empresa = fv.empresa    and fva.numero_serie_egr = fv.numero_serie and fva.numero_factura_egr = fv.numero_factura and fva.ejercicio_egr = fv.ejercicio    and fv2.empresa = fv.empresa and fv2.numero_serie = fva.numero_serie_fra and fv2.numero_factura = fva.numero_factura_fra    and fv2.ejercicio = fva.ejercicio_fra and fv2.numero_asiento_borrador is null ) and NVL (fv.fecha_contabilizacion, fv.fecha_factura) > to_date('31/12/2022', 'dd/mm/yyyy') and fv.status_factura = '1600' and not exists (SELECT 1 FROM facturas_sustituciones fa WHERE fa.empresa = fv.empresa AND fa.numero_serie = fv.numero_serie AND fa.ejercicio = fv.ejercicio AND fa.numero_factura = fv.numero_factura AND NVL (fa.forzar_contabilizacion, 'N') = 'N') and (rs.factura_electronica(+) <> 'C') ORDER BY DECODE (rs.cfd_cronologico, 'S', fv.fecha_impresion, fv.fecha_factura), fv.fecha_factura, fv.organizacion_comercial, fv.numero_serie, fv.numero_factura




/********* query tipo pedidos *************/
SELECT * 
FROM TIPOS_PEDIDO_VTA      
WHERE organizacion_comercial LIKE '%010' AND codigo_empresa IN  ('999', '004','002' )


/**********************/



:where_lov AND bloqueo_pedidos != 'S' 
AND EXISTS (SELECT 1 FROM clientes_parametros cp WHERE cp.codigo_cliente = clientes.codigo_rapido AND cp.empresa = :global.codigo_empresa AND iva_incluido = :b1.tp_impuesto_incluido) 
AND ((:b1.cc_empresa_sn = 'S' AND centro_contable = :b1.centro_contable) OR (:b1.cc_empresa_sn = 'N' AND (centro_contable IS NULL OR centro_contable = :b1.centro_contable OR (centro_contable != :b1.centro_contable AND EXISTS (SELECT 1 FROM caracteres_asiento ca WHERE ca.codigo = clientes.centro_contable AND ca.empresa = :global.codigo_empresa AND ca.empresa_sn = 'N'))))) 


AND (:b1.oc_por_actividades = 'N' OR (codigo_actividad IS NULL OR EXISTS (SELECT 1 FROM org_comer_actividades oca WHERE oca.codigo_actividad = clientes.codigo_actividad AND oca.org_comercial = :b1.organizacion_comercial AND oca.codigo_empresa = :global.codigo_empresa))) 


AND NOT EXISTS (SELECT 1 FROM cliente_tipo_pedido r WHERE r.codigo_cliente = clientes.codigo_rapido AND r.organizacion_comercial = :b1.organizacion_comercial AND r.tipo_pedido = :b1.tipo_pedido AND r.empresa = :global.codigo_empresa)

AND (   tipo_cliente NOT IN (SELECT tipo_cliente
                                    FROM tip_ped_vta_tip_cli
                                   WHERE organizacion_comercial =:b1.organizacion_comercial
                                  AND empresa =:global.codigo_empresa)
          OR tipo_cliente IN (
                       SELECT tipo_cliente
                         FROM tip_ped_vta_tip_cli
                        WHERE tipo_pedido =:b1.tipo_pedido
                             AND organizacion_comercial =:b1.organizacion_comercial
                              AND empresa =:global.codigo_empresa))
  
     AND ((:b1.traspaso != 'S'
         OR :parameter.usar_alm_dest_cm_trasp_vta != 'N'
         OR :parameter.existe_cli_alm_zonas != 'S')
         OR EXISTS(
                   SELECT 1
                     FROM almacenes_zonas az
                    WHERE az.codigo_empresa = clientes.codigo_empresa
                      AND az.codigo_almacen = :b1.almacen_pedido
                      AND az.codigo_cliente = clientes.codigo_rapido )
        )


SELECT tipo_cliente
                                    FROM tip_ped_vta_tip_cli
                                   WHERE organizacion_comercial ='04010'
                                  AND empresa '002'


SELECT empresa, organizacion_comercial , tipo_cliente
 FROM tip_ped_vta_tip_cli
 WHERE organizacion_comercial ='02010'

select *
 FROM org_comer_actividades oca 
 WHERE oca.codigo_actividad = 'R0018' AND oca.org_comercial = '02010' AND oca.codigo_empresa = '0201'






WHERE codigo_empresa = :GLOBAL.codigo_empresa 
AND (:GLOBAL.usuario = :GLOBAL.superusuario OR NOT EXISTS (
SELECT 1 FROM bloqueo_clientes
WHERE empresa = :GLOBAL.codigo_empresa
AND codigo_cliente = codigo_rapido
AND (usuario = :GLOBAL.usuario OR usuario IS NULL)
AND (TRUNC(SYSDATE) >= desde_fecha) AND (TRUNC(SYSDATE) <= hasta_fecha))) 
AND PKVALIDAR_ENTIDADES.CLIENTE(CODIGO_RAPIDO,:GLOBAL.CODIGO_EMPRESA,:GLOBAL.USUARIO,SYSDATE,'S')='OK' 
and plantilla_libra like case when :global.codigo_empresa = '003' then 'EC%' else '%%' end