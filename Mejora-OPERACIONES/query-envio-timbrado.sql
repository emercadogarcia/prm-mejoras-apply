/*** QUERY PARA OBTENER NUMERO PEDIDO -FACTURA - REMISIONES **/

SELECT EJERCICIO,NUMERO_SERIE,NUMERO_PEDIDO, NUMERO_PROPUESTA,NUMERO_LINEA, status_linea
FROM PEDIDOS_VENTAS_LIN
WHERE EMPRESA='004' AND STATUS_LINEA IN ('P','R') AND UNIDADES_SERVIDAS=0 and 
EXISTS (SELECT 1 FROM PEDIDOS_VENTAS PV WHERE PV.EMPRESA=PEDIDOS_VENTAS_LIN.EMPRESA AND PV.NUMERO_SERIE=PEDIDOS_VENTAS_LIN.NUMERO_SERIE AND PV.NUMERO_PEDIDO=PEDIDOS_VENTAS_LIN.NUMERO_PEDIDO AND PV.EJERCICIO=PEDIDOS_VENTAS_LIN.EJERCICIO AND  PV.FECHA_PEDIDO >= TO_DATE('01/10/2024','DD/MM/YYYY') AND PV.FECHA_PEDIDO <= TO_DATE('30/10/2024','DD/MM/YYYY'))
GROUP BY EJERCICIO,NUMERO_SERIE,NUMERO_PEDIDO, NUMERO_PROPUESTA,NUMERO_LINEA, status_linea
HAVING NUMERO_PROPUESTA  IS NOT NULL
ORDER BY NUMERO_PROPUESTA
/****** FIN ORGINAL */


/*** QUERY MODIFICADA */
, NUMERO_PROPUESTA
WHERE EMPRESA='004' AND  STATUS_LINEA IN ('F','S')

declare 
year integer;
nro_serie varchar2(3);
nro_ped integer;
begin 
SELECT distinct EJERCICIO,NUMERO_SERIE,NUMERO_PEDIDO
into year, nro_serie, nro_ped
FROM PEDIDOS_VENTAS_LIN
where empresa='004' and NUMERO_PROPUESTA= :B1.HOJA_CARGA  and SERIE_HOJA_CARGA = :B1.SERIE_HOJA_CARGA 
and EJERCICIO_PROPUESTA =EXTRACT(YEAR FROM to_date(nvl(:B1.FECHA_EXPEDICION, current_Date),'DD/MM/YYYY')) ;

and EJERCICIO_PROPUESTA in (nvl(B1.FECHA_EXPEDICION, current_Date)) 

/*** mensaje prueba */
:p_tipo_mensaje := 'CAMPO';
:p_codigo_mensaje := 'TEXTOLIB';
:p_texto_mensaje := 'Datos obtenido, años: ' ||year || ' Nro_serie: ' || nro_serie ||' Nro_ped: '||nro_ped;
:p_parar_ejecucion := 'N';
end;

/********* fin query prueba***************/

AND  EXISTS (SELECT 1 FROM PEDIDOS_VENTAS PV WHERE PV.EMPRESA=PEDIDOS_VENTAS_LIN.EMPRESA AND PV.NUMERO_SERIE=PEDIDOS_VENTAS_LIN.NUMERO_SERIE AND PV.NUMERO_PEDIDO=PEDIDOS_VENTAS_LIN.NUMERO_PEDIDO AND PV.EJERCICIO=PEDIDOS_VENTAS_LIN.EJERCICIO AND  PV.FECHA_PEDIDO >= TO_DATE('01/10/2024','DD/MM/YYYY') AND PV.FECHA_PEDIDO <= TO_DATE('30/10/2024','DD/MM/YYYY'))
GROUP BY EJERCICIO,NUMERO_SERIE,NUMERO_PEDIDO, NUMERO_PROPUESTA,NUMERO_LINEA, status_linea

--v_year_fac:= EXTRACT(YEAR FROM to_date(:b1.FECHA_PEDIDO_char,'DD/MM/YYYY'));

/******************************************************************/

/******************************************************************/
/******************************************************************/
/******* script para enviar a timbrar la factura generada *********/

declare
v_nro_fac number:=0;
v_serie_fac varchar2(3);
v_year_fac number; 
v_fecha date;
year integer;
nro_serie varchar2(3);
nro_ped integer:=0;
begin 
if :global.codigo_empresa = '004'
SELECT distinct EJERCICIO,NUMERO_SERIE, nvl(NUMERO_PEDIDO,0) n_ped
into year, nro_serie, nro_ped
FROM PEDIDOS_VENTAS_LIN
where empresa='004' and NUMERO_PROPUESTA= :B1.HOJA_CARGA  and SERIE_HOJA_CARGA = :B1.SERIE_HOJA_CARGA and EJERCICIO_PROPUESTA =EXTRACT(YEAR FROM to_date(nvl(:B1.FECHA_EXPEDICION, current_Date),'DD/MM/YYYY')) ;

if  nro_ped>0 THEN 
SELECT DISTINCT A.NUMERO_SERIE_FRA,A.NUMERO_FACTURA,f.FECHA_FACTURA, f.ejercicio
into v_serie_fac, v_nro_fac,v_fecha , v_year_fac
FROM facturas_ventas f, albaran_ventas a, albaran_ventas_lin al, pedidos_ventas p 
WHERE p.empresa = '004' AND p.organizacion_comercial = '04010'
AND p.ejercicio = year AND p.numero_serie = nro_serie AND p.numero_pedido = nro_ped
AND al.empresa(+) = p.empresa AND al.organizacion_comercial(+) = p.organizacion_comercial 
AND al.numero_serie_pedido(+) = p.numero_serie AND al.numero_pedido(+) = p.numero_pedido 
AND al.ejercicio_pedido(+) = p.ejercicio AND a.empresa = al.empresa 
AND a.organizacion_comercial = al.organizacion_comercial AND a.numero_serie = al.numero_serie 
AND a.numero_albaran = al.numero_albaran AND a.sub_albaran = al.sub_albaran 
AND a.ejercicio = al.ejercicio AND f.empresa(+) = a.empresa 
AND f.organizacion_comercial(+) = a.organizacion_comercial AND f.ejercicio(+) = a.ejercicio_factura 
AND f.numero_serie(+) = a.numero_serie_fra AND f.numero_factura(+) = a.numero_factura;
IF v_nro_Fac IS NOT NULL THEN 
 :global.id_personalizacion := '4';        	
 :p_ejecutar_programa := 'FE_FIRMFAC';        	
 :p_modo_menu_prog_llamado := 'DO_REPLACE';           	
 PKPANTALLAS.INICIALIZAR_PARAMETROS_PLUG_IN;
 PKPANTALLAS.PARAMETRO_PLUG_IN('EMPRESA', 'C','004');
 PKPANTALLAS.PARAMETRO_PLUG_IN('EJERCICIO', 'C',v_year_fac);
 PKPANTALLAS.PARAMETRO_PLUG_IN('DESDE_FECHA', 'C',v_fecha);
 PKPANTALLAS.PARAMETRO_PLUG_IN('HASTA_FECHA', 'C',v_fecha);
 PKPANTALLAS.PARAMETRO_PLUG_IN('NUMERO_SERIE', 'C',v_serie_fac);
 PKPANTALLAS.PARAMETRO_PLUG_IN('NUMERO_FACTURA', 'C',v_nro_fac);
 PKPANTALLAS.PARAMETRO_PLUG_IN('ORGANIZACION_COMERCIAL', 'C','04010');
 PKPANTALLAS.PARAMETRO_PLUG_IN('PERMITIR_CONSULTA_INCIDENCIAS', 'C','S');
 PKPANTALLAS.PARAMETRO_PLUG_IN('TIPO_OPERACION', 'C','E');
 PKPANTALLAS.PARAMETRO_PLUG_IN('PA01', 'C','VTAS_DIR');
 END IF;
 END IF;
 end if;
 END;
/******************************************************************/
/******************************************************************/
/******************************************************************/


SELECT distinct EJERCICIO,NUMERO_SERIE,NUMERO_PEDIDO
FROM PEDIDOS_VENTAS_LIN
where empresa='004' and NUMERO_PROPUESTA= 35  and SERIE_HOJA_CARGA = '410'
and EJERCICIO_PROPUESTA =EXTRACT(YEAR FROM to_date(nvl('22/10/2024', current_Date),'DD/MM/YYYY')) ;
