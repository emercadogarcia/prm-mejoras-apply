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
and codigo_rapido BETWEEN '023888' and '023929'
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

SELECT CODIGO_EMPRESA,ORGANIZACION_COMERCIAL,TIPO_PEDIDO,DESCRIPCION,CIRCUITO_FACTURACION,COD_MVTO_SALIDA_ALBARANES,D_COD_MVTO_SALIDA_ALBARANES,TIPO_PEDIDO_EDI,D_TIPO_PEDIDO_EDI,TIPO_FACTURA_EDI,TIPO_PEDIDO_EDI_ENV,D_TIPO_PEDIDO_EDI_ENV,RAZON_ABONO_EDI,FORMA_PAGO,D_FORMA_PAGO,ESCALA_DESCUENTOS,D_ESCALA_DESCUENTOS,PRIORIDAD,DESCUENTO_ADICIONAL,BONIFICACION_UNIDADES,BONIFICACION_CADA,SUFIJO_CONTABLE,SUFIJO_CONTABLE2,AUTOM_COMPRA,DIAS_MIN_CADUCIDAD,CONTABILIZAR_PD,MATRICULA_ALB,MATRICULA_PED,MOVER_ALMACEN,CONTROL_RIESGO,PREPARACION_RADIO,ALBARAN_VALORADO,MOSTRAR_ALERTAS_RIESGO,PEDIDO_ESPECIAL,AJUSTE_CUOTAS_II,TARA_ALB_LIN,DEVOLUCION,DEVOLUCION_AUTOMATICA,DCTOS_SIN_CARGOS,DCTOS_SIN_CARGOS_FACT,DCTOS_MODIFICABLES,PEDIDO_ET,PEDIR_PERIODO_RECTIFICACION,CONTRATO_OBLIGATORIO,MOSTRAR_RIESGO,IMPUESTO_INCLUIDO,VALORADO,TRATAR_PORTES,ALBARAN_SIN_RECETA,NO_IMPRIMIR_ALBARAN,ALBARAN_DIR_CONFIRMAR,CALC_AC,LICITACION,ENVIAR_INDUSTRIA,BI,IGNORAR_DIVISA_CONTA,PROFORMA,TRATAR_EN_COMISION_REPARTO,MODIFICAR_FORMA_COBRO,ALBARAN_INTERNO,LINEA_CREDITO,PEDIR_OBRA_DESTINO,SEGUNDA_FORMA_COBRO,CALCULA_IDTO_1,AUTORIZACION_LIN_SIN_PRECIO,PREPARACION_CON_UBICACIONES,TRASLADO,MOTIVO_TRASLADO,D_MOTIVO_TRASLADO,TIPO_DESUBICACION,REPLICAPV_LIN_PEDVTA_ORIGEN,RETENCION,PACKAGE_FINPRES,PACKAGE_FINPED,PACKAGE_FINALB,PACKAGE_FINALB_DESP_IMP,PACKAGE_FIN_PRECIOS,PACKAGE_FINREPLI,PAQUETE_PREVIO_ANULACION,PACKAGE_COMPROB_FACTURA,RESERVA_MANUAL_LOT_SER_ALB,RESERVA_MANUAL_LOT_SER_PED,CARGO_PLANTILLA,GENERAR_CARGO_PLANTILLA,PERMITIR_ALBARAN_CIERRE,ALBARANAR_PEDIDO_IMPORTADO,TIPO_CONF_PEDIDO,D_TIPO_CONF_PEDIDO,HORAS_BLOQUEO_ALBARAN,PAQUETE_RECALCULO_INTRASTAT,PROVEEDOR_SERVICIOS_DIRECTOS,D_PROVEEDOR_SERVICIOS_DIRECTOS,TRATAMIENTO_ARTICULO_DESTINO,ARTICULO_DESTINO,D_ARTICULO_DESTINO,TRATAMIENTO_SURTIDOS,NO_FILTRAR_ORG_EN_CLIENTE,CARGAR_AGENTE_USU_ALT,RESERVAR_STOCK_PED,PEDIR_RECETA_MANUAL,USAR_DATOS_MOV_TRASP,CONTROL_ORIGEN_RECETA,PACKAGE_NO_CONFORME,ALMACEN_CAJA,D_ALMACEN_CAJA,TIPO_PEDIDO_COMPRA_ASOC,D_TIPO_PEDIDO_COMPRA_ASOC,EX_CONTRATOS,TAREA_ABONOS,MANTENER_SIT_ORIG_TRASP,CONTROL_TARIFA_SUELO,DESGLOSAR_PEDIDOS,APLICAR_PLANTILLAS_TS,PERMITIR_MODIFICAR_PACKAS,REEMBOLSO,APLICAR_CONCEPTOS_TS,APLICAR_DTOS_CABECERA_TS,NOTA_DEBITO,TRAT_ANULACION,NOTA_CREDITO,SOLO_FRAS_NC_POSITIVAS,DEVOLUCION_AV_ORIGINAL,CONTROL_CANTIDADES_NC,clase_hoja_carga,GEN_HC_AUTOMATICA,TIPO_ENVIO_ALBARAN,D_TIPO_ENVIO_ALBARAN,CODIGO_PADRE,D_CODIGO_PADRE,TIPO_IMPUESTO_ENTIDAD,D_TIPO_IMPUESTO_ENTIDAD,PREDEFINIDO,D_PREDEFINIDO,PREDEFINIDO_ANTICIPOS,D_PREDEFINIDO_ANTICIPOS,AGRUPACION_AUTO_ANTI,TIPO_TRANSACCION_COMPENSAR,D_TIPO_TRANSACCION_COMPENSAR,MULTIALMACEN,PEDIDO_CT,MAQUILA,PEDIDO_FRIO,INTEGRACION_TPV_PESCA,REVISAR_LOTE_DEV,CM_ITINERANCIA,D_CM_ITINERANCIA,TIPO_EXPEDIENTE,D_TIPO_EXPEDIENTE,PACKAGE_ALMACEN_ENTREGA,GENERAR_EXPEDIENTE,PEDIR_EXPEDIENTE,PEDIR_HOJA_SEGUIMIENTO,PEDIR_DATOS_PROYECTO,PREV_LIN_PED,PEDIR_DOC_DUA,AGENTE_CLIENTE_ENTREGA,SIS_AUTORIZACION_PEDIDOS,ACUM_PED_NO_AUTORIZ,TIPO_DOCUMENTO_DIOR,D_TIPO_DOCUMENTO_DIOR,OPERACION_DIOR,D_OPERACION_DIOR,CONTROL_AGENTES,CLI_CENTROS_EMPRESA_EN_ALB,TV_TRATAMIENTO_DEPOSITOS,SIT_DEST_TRASP_OF,RF_TRATAMIENTO_PALETS_EXP,DESGLOSE_LINEA_PRESUPUESTO,DESGLOSE_LINEA_PEDIDO,PARTIR_LINEA_PV_AL_RESERVAR,VINCULAR_FAC_EXT,USO_RECEPTOR_CFDI,COLOR_PANEL,D_USO_RECEPTOR_CFDI,INCLUIR_IMPRESION_FISCAL,TIPO_DOCUMENTO_SARA,D_TIPO_DOCUMENTO_SARA,SOLICITAR_OT_DOCS,ARTICULO_IMPRESION,D_ARTICULO_IMPRESION,MOTIVO_DEVOLUCION,D_MOTIVO_DEVOLUCION,MOTIVO_SURTIDO,D_MOTIVO_SURTIDO,NATURALEZA_INTRASTAT,D_NATURALEZA_INTRASTAT,REG_ESTADISTICO_INTRASTAT,D_REG_ESTADISTICO_INTRASTAT,DOC_BASE_INTRASTAT,TIPO_OPERACION,D_TIPO_OPERACION,COD_MOV_DEP_ENVASE,D_COD_MOV_DEP_ENVASE,COD_MOV_DEP_PROV_ENVASE,D_COD_MOV_DEP_PROV_ENVASE,EXPORTACION,D_EXPORTACION,MODIFICAR_PEDIDOS_HC,FECHA_ALB_PREP,FECHA_VAL_ALB_PREP,TRATAMIENTO_STOCK,FARMA_PEDIDO_ESPECIAL,FARMA_VALORACION_ABONOS_CADUC,FARMA_TIPO_ABONO,FARMA_DESCRIPCION_ALBARAN,FARMA_DIAS_ADIC_FP,FARMA_DESCUENTO_MAXIMO,FARMA_PRECIO_VALORACION,FARMA_IMPRESORA_HOJA_PUESTA,D_FARMA_IMPRESORA_HOJA_PUESTA,FARMA_IMPRESORA_ALBARANES,D_FARMA_IMPRESORA_ALBARANES,FARMA_IMPRESORA_GRAN_VOLUMEN,D_FARMA_IMPRESORA_GRAN_VOLUMEN,FARMA_TRATAMIENTO_LINEA,FARMA_MODEM,FARMA_DCTO_MODEM,FARMA_AYUDA_COMPRA,FARMA_FILTRAR_ART_PROV,FARMA_IMPRIMIR_ESTANTERIA,FARMA_MODIFICAR_ESCALA,FARMA_MODIFICAR_RUTA,FARMA_MODIFICAR_BONIFICACION,FARMA_MODIFICAR_DIAS_ADIC,FARMA_APLAZA_FECHA_FACTURA,FARMA_GENERACION_AUT_ALBARAN,FARMA_PEDIDO_ENVASE_ORIGEN,VA_AL_TE,FARMA_PARTIR_PEDIDO,ROBOT,FARMA_INCLUIR_CLUB,FARMA_ENVIO_FARMADATA,INCLUIR_BONIFICACION,FARMA_EXCLUIR_PL,FARMA_CONTROL_TD,FARMA_INCLUIR_MERMA_PL,FARMA_PERMITIR_ESTUPEFACIENTES,FARMA_PEDIDO_EXCLUSIVO,FARMA_PERMITIR_CONTROLADOS,FARMA_IMPORTE_SALTO,FARMA_PEDIDO_SALTO,D_FARMA_PEDIDO_SALTO,FARMA_PEDIDO_PDTE_POR_IMPORTE,FARMA_IMPORTE_MAX_SALTO,FARMA_PEDIDO_MAX_SALTO,D_FARMA_PEDIDO_MAX_SALTO,FARMA_COMPACTACION_PEDIDOS,TIPO_PEDIDO_COMPACTACION,D_TIPO_PEDIDO_COMPACTACION,PEDIDO_ESPECIAL_PRODUCCION,D_SIT_DEST_TRASP_OF,OBLIGAR_NC_CON_ORI_TIMBR,MANTENER_TRANSPORTE_HCAUTO,OBLIGAR_DATOS_FAC_REEM,CONTROL_IMPORTES_NC 
FROM (SELECT TIPOS_PEDIDO_VTA.* ,(select nombre from almacenes where almacen = tipos_pedido_vta.almacen_caja AND codigo_empresa = tipos_pedido_vta.codigo_empresa ) D_ALMACEN_CAJA,(SELECT descrip_comercial FROM articulos WHERE codigo_articulo = tipos_pedido_vta.articulo_destino AND codigo_empresa = tipos_pedido_vta.codigo_empresa) D_ARTICULO_DESTINO,(select  descrip_comercial from articulos where codigo_empresa = TIPOS_PEDIDO_VTA.CODIGO_EMPRESA and codigo_articulo=tipos_pedido_vta.articulo_impresion ) D_ARTICULO_IMPRESION,(SELECT CM.DESCRIPCION FROM CODIGOS_MOVIMIENTO CM WHERE CM.CODIGO_MOVIMIENTO = TIPOS_PEDIDO_VTA.CM_ITINERANCIA AND CM.CODIGO_EMPRESA = TIPOS_PEDIDO_VTA.CODIGO_EMPRESA) D_CM_ITINERANCIA,(select descripcion from tipos_pedido_vta tpv where tipos_pedido_vta.codigo_empresa = tpv.codigo_empresa and tipos_pedido_vta.organizacion_comercial = tpv.organizacion_comercial and tipos_pedido_vta.codigo_padre = tpv.tipo_pedido) D_CODIGO_PADRE,DECODE(tipos_pedido_vta.cod_mov_dep_envase,NULL,NULL,(SELECT lvcodm.descripcion FROM codigos_movimiento lvcodm WHERE lvcodm.codigo_movimiento = tipos_pedido_vta.cod_mov_dep_envase AND lvcodm.codigo_empresa = tipos_pedido_vta.codigo_empresa)) D_COD_MOV_DEP_ENVASE,DECODE(tipos_pedido_vta.cod_mov_dep_prov_envase,NULL,NULL,(SELECT lvcodm.descripcion FROM codigos_movimiento lvcodm WHERE lvcodm.codigo_movimiento = tipos_pedido_vta.cod_mov_dep_prov_envase AND lvcodm.codigo_empresa = tipos_pedido_vta.codigo_empresa)) D_COD_MOV_DEP_PROV_ENVASE,(SELECT descripcion FROM codigos_movimiento WHERE codigo_empresa = tipos_pedido_vta.codigo_empresa AND codigo_movimiento = tipos_pedido_vta.cod_mvto_salida_albaranes) D_COD_MVTO_SALIDA_ALBARANES,(SELECT descripcion FROM escala_descuentos WHERE codigo = tipos_pedido_vta.escala_descuentos AND empresa = tipos_pedido_vta.codigo_empresa) D_ESCALA_DESCUENTOS,(SELECT lvfeexsat.descripcion from fe_exportacion_sat lvfeexsat WHERE lvfeexsat.codigo = TIPOS_PEDIDO_VTA.EXPORTACION) D_EXPORTACION,(SELECT DESCRIPCION FROM impresoras_logicas I WHERE I.CODIGO = tipos_pedido_vta.farma_impresora_albaranes) D_FARMA_IMPRESORA_ALBARANES,(SELECT DESCRIPCION FROM impresoras_logicas I WHERE I.CODIGO = tipos_pedido_vta.farma_impresora_gran_volumen) D_FARMA_IMPRESORA_GRAN_VOLUMEN,(SELECT DESCRIPCION FROM impresoras_logicas I WHERE I.CODIGO = tipos_pedido_vta.farma_impresora_hoja_puesta) D_FARMA_IMPRESORA_HOJA_PUESTA,decode (FARMA_PEDIDO_MAX_SALTO, null, null, (select descripcion from tipos_pedido_vta b where b.codigo_empresa = tipos_pedido_vta.codigo_empresa and b.organizacion_comercial = tipos_pedido_vta.organizacion_comercial and b.tipo_pedido= tipos_pedido_vta.FARMA_PEDIDO_MAX_SALTO)) D_FARMA_PEDIDO_MAX_SALTO,decode (FARMA_PEDIDO_SALTO, null, null, (select descripcion from tipos_pedido_vta b where b.codigo_empresa = tipos_pedido_vta.codigo_empresa and b.organizacion_comercial = tipos_pedido_vta.organizacion_comercial and b.tipo_pedido= tipos_pedido_vta.FARMA_PEDIDO_SALTO)) D_FARMA_PEDIDO_SALTO,(SELECT nombre FROM formas_cobro_pago WHERE codigo = tipos_pedido_vta.forma_pago) D_FORMA_PAGO,(select md.descripcion from motivos_devolucion md where md.codigo_motivo = tipos_pedido_vta.motivo_devolucion) D_MOTIVO_DEVOLUCION,(SELECT DESCRIPCION FROM motivos_anul_ped_vta   WHERE codigo_motivo = tipos_pedido_vta.motivo_surtido) D_MOTIVO_SURTIDO,( select mt.descripcion from fe_motivos_traslado mt where mt.codigo=tipos_pedido_vta.motivo_traslado) D_MOTIVO_TRASLADO,(SELECT intrastat_naturalezas.descripcion FROM intrastat_naturalezas WHERE intrastat_naturalezas.codigo= TIPOS_PEDIDO_VTA.NATURALEZA_INTRASTAT) D_NATURALEZA_INTRASTAT,(select descripcion from operaciones_dior o where o.codigo_empresa = tipos_pedido_vta.codigo_empresa and o.codigo = tipos_pedido_vta.operacion_dior) D_OPERACION_DIOR,(select descripcion from asientos_predefinidos where empresa = tipos_pedido_vta.codigo_empresa and codigo = predefinido) D_PREDEFINIDO,(select descripcion from asientos_predefinidos where empresa = tipos_pedido_vta.codigo_empresa and codigo = predefinido_anticipos) D_PREDEFINIDO_ANTICIPOS,(select nombre from proveedores where codigo_rapido = tipos_pedido_vta.proveedor_servicios_directos and codigo_empresa = tipos_pedido_vta.codigo_empresa) D_PROVEEDOR_SERVICIOS_DIRECTOS,DECODE(tipos_pedido_vta.reg_estadistico_intrastat,NULL,NULL,(SELECT intrastat_reg_estadistico.descripcion FROM intrastat_reg_estadistico WHERE intrastat_reg_estadistico.codigo= tipos_pedido_vta.reg_estadistico_intrastat)) D_REG_ESTADISTICO_INTRASTAT,DECODE(TIPOS_PEDIDO_VTA.SIT_DEST_TRASP_OF,NULL,NULL,(SELECT lvts.descripcion FROM tipos_situacion lvts WHERE lvts.tipo_situacion = TIPOS_PEDIDO_VTA.SIT_DEST_TRASP_OF AND lvts.codigo_empresa = TIPOS_PEDIDO_VTA.CODIGO_EMPRESA)) D_SIT_DEST_TRASP_OF,(SELECT descripcion FROM tipos_conf_pedido WHERE codigo = tipos_pedido_vta.tipo_conf_pedido) D_TIPO_CONF_PEDIDO,(select descripcion from tipos_documento_dior td where td.codigo_empresa = tipos_pedido_vta.codigo_empresa and td.codigo = tipos_pedido_vta.tipo_documento_dior) D_TIPO_DOCUMENTO_DIOR,decode(tipos_pedido_vta.tipo_documento_sara,null,null,(select ti.descripcion from sara_tipos_documentos ti where ti.empresa = tipos_pedido_vta.codigo_empresa and ti.codigo=tipos_pedido_vta.tipo_documento_sara)) D_TIPO_DOCUMENTO_SARA,DECODE(tipo_envio_albaran,NULL,NULL,(SELECT p.descripcion FROM tipos_envio_albaran p WHERE p.codigo = TIPOS_PEDIDO_VTA.tipo_envio_albaran)) D_TIPO_ENVIO_ALBARAN,(select descripcion
  from tipos_expedientes_imp e
 where     tipos_pedido_vta.codigo_empresa = e.empresa
       and tipos_pedido_vta.tipo_expediente = e.codigo) D_TIPO_EXPEDIENTE,(select descripcion from tipos_impuesto_entidad tie where tie.tipo_impuesto = TIPOS_PEDIDO_VTA.tipo_impuesto_entidad) D_TIPO_IMPUESTO_ENTIDAD,(SELECT tod.descripcion FROM tipos_oper_detraccion tod WHERE tod.tipo_operacion = TIPOS_PEDIDO_VTA.TIPO_OPERACION) D_TIPO_OPERACION,decode (TIPO_PEDIDO_COMPACTACION, null, null, (select descripcion from tipos_pedido_vta b where b.codigo_empresa = tipos_pedido_vta.codigo_empresa and b.organizacion_comercial = tipos_pedido_vta.organizacion_comercial and b.tipo_pedido= tipos_pedido_vta.tipo_pedido_compactacion)) D_TIPO_PEDIDO_COMPACTACION,(SELECT descripcion FROM tipos_pedido_com WHERE tipo_pedido = tipos_pedido_vta.tipo_pedido_compra_asoc and organizacion_compras = (SELECT ORG_COMPRAS FROM PARAM_VENTAS WHERE CODIGO_EMPRESA =tipos_pedido_vta.CODIGO_EMPRESA and ORGANIZACION_COMERCIAL = tipos_pedido_vta.ORGANIZACION_COMERCIAL) and codigo_empresa= tipos_pedido_vta.codigo_empresa) D_TIPO_PEDIDO_COMPRA_ASOC,(SELECT l.c2 FROM v_listas_valores_estaticos l WHERE l.codigo_lista = 'EANCOM_TIPOS_PEDIDO' AND l.codigo_registro = tipos_pedido_vta.tipo_pedido_edi) D_TIPO_PEDIDO_EDI,(SELECT l.c2 FROM v_listas_valores_estaticos l WHERE l.codigo_lista = 'EANCOM_TIPOS_PEDIDO' AND l.codigo_registro = tipos_pedido_vta.tipo_pedido_edi_env) D_TIPO_PEDIDO_EDI_ENV,(SELECT nombre FROM tipos_transacciones WHERE codigo = tipos_pedido_vta.tipo_transaccion_compensar) D_TIPO_TRANSACCION_COMPENSAR,(select fe.descripcion from fe_uso_cfdi_sat fe where fe.codigo = tipos_pedido_vta.uso_receptor_cfdi) D_USO_RECEPTOR_CFDI FROM TIPOS_PEDIDO_VTA) TIPOS_PEDIDO_VTA 
      

      WHERE organizacion_comercial = '04010' AND codigo_empresa = '999' and (ORGANIZACION_COMERCIAL='04010') order by TIPO_PEDIDO

SELECT * 
FROM TIPOS_PEDIDO_VTA      
WHERE organizacion_comercial LIKE '%010' AND codigo_empresa IN  ('999', '004','002' )


/**********************/