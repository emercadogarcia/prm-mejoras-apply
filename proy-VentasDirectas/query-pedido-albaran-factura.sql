/**** query PEDIDO + ALBARAN + FACTURA *******/
/*** CONSULTA PARA OBTENER PEDIDO ALBARAN Y FACTURA */
SELECT DISTINCT A.NUMERO_SERIE,A.NUMERO_ALBARAN,A.SUB_ALBARAN,A.FECHA_PEDIDO,A.NUMERO_SERIE_FRA,A.NUMERO_FACTURA,f.FECHA_FACTURA 
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

/**************************************************************************/
declare
v_nro_fac number:=0;
v_serie_fac varchar2(3);
v_year_fac number; 
v_fecha date;
begin
if :B1.NUMERO_PEDIDO IS NOT NULL AND :B1.NUMERO_SERIE IS NOT NULL THEN 
v_year_fac:= EXTRACT(YEAR FROM to_date(:b1.FECHA_PEDIDO_char,'DD/MM/YYYY'));
SELECT DISTINCT A.NUMERO_SERIE_FRA,A.NUMERO_FACTURA,f.FECHA_FACTURA, f.ejercicio
into v_serie_fac, v_nro_fac,v_fecha , v_year_fac
FROM facturas_ventas f, albaran_ventas a, albaran_ventas_lin al, pedidos_ventas p 
WHERE p.empresa = '004' AND p.organizacion_comercial = :b1.ORGANIZACION_COMERCIAL
AND p.ejercicio = v_year_fac AND p.numero_serie = :B1.NUMERO_SERIE AND p.numero_pedido = :B1.numero_pedido
AND al.empresa(+) = p.empresa AND al.organizacion_comercial(+) = p.organizacion_comercial 
AND al.numero_serie_pedido(+) = p.numero_serie AND al.numero_pedido(+) = p.numero_pedido 
AND al.ejercicio_pedido(+) = p.ejercicio AND a.empresa = al.empresa 
AND a.organizacion_comercial = al.organizacion_comercial AND a.numero_serie = al.numero_serie 
AND a.numero_albaran = al.numero_albaran AND a.sub_albaran = al.sub_albaran 
AND a.ejercicio = al.ejercicio AND f.empresa(+) = a.empresa 
AND f.organizacion_comercial(+) = a.organizacion_comercial AND f.ejercicio(+) = a.ejercicio_factura 
AND f.numero_serie(+) = a.numero_serie_fra AND f.numero_factura(+) = a.numero_factura;
IF v_nro_Fac IS NOT NULL THEN 
 :global.id_personalizacion := '1';        	
 :p_ejecutar_programa := 'FE_FIRMFAC';        	
 :p_modo_menu_prog_llamado := 'DO_REPLACE';           	
 PKPANTALLAS.INICIALIZAR_PARAMETROS_PLUG_IN;
 PKPANTALLAS.PARAMETRO_PLUG_IN('EMPRESA', 'C','004');
 PKPANTALLAS.PARAMETRO_PLUG_IN('EJERCICIO', 'C',v_year_fac);
 PKPANTALLAS.PARAMETRO_PLUG_IN('DESDE_FECHA', 'C',v_fecha);
 PKPANTALLAS.PARAMETRO_PLUG_IN('HASTA_FECHA', 'C',v_fecha);
 PKPANTALLAS.PARAMETRO_PLUG_IN('NUMERO_SERIE', 'C',v_serie_fac);
 PKPANTALLAS.PARAMETRO_PLUG_IN('NUMERO_FACTURA', 'C',v_nro_fac);
 PKPANTALLAS.PARAMETRO_PLUG_IN('ORGANIZACION_COMERCIAL', 'R',:B1.ORGANIZACION_COMERCIAL);
 PKPANTALLAS.PARAMETRO_PLUG_IN('PERMITIR_CONSULTA_INCIDENCIAS', 'C','S');
 PKPANTALLAS.PARAMETRO_PLUG_IN('TIPO_OPERACION', 'C','E');
 PKPANTALLAS.PARAMETRO_PLUG_IN('PA01', 'C','VTAS_DIR');
 END IF;
 END IF;
 END;

-- FIN del codigo para lanzar 

 PKPANTALLAS.PARAMETRO_PLUG_IN('PA02', 'C','04');
 PKPANTALLAS.PARAMETRO_PLUG_IN('PA03', 'C','01');
 PKPANTALLAS.PARAMETRO_PLUG_IN('PA04', 'C',:global.fecha_trabajo);
 PKPANTALLAS.PARAMETRO_PLUG_IN('PA05', 'C',:PARAMETER.PA05);
 PKPANTALLAS.PARAMETRO_PLUG_IN('PA06', 'C',:PARAMETER.PA06);
 PKPANTALLAS.PARAMETRO_PLUG_IN('PA07', 'C',:PARAMETER.PA07);



/**************************************************************************/
/**************************************************************************/



/**** codigo para llamar programa y ejecutar directamente */
declare 
    v_serie_fac varchar2(3);
    v_nro_Fac number;
    v_year_Fac number; 
    v_factura number :=0;
    v_liq_alb number;
    BEGIN 
    SELECT NUMERO_FACTURA, FECHA_FACTURA, NUMERO_SERIE_FRA,NUMERO_SERIE_FRA, numero_factura, ejercicio_factura 
    INTO :PARAMETER.PA05, :PARAMETER.PA06, :PARAMETER.PA07, v_serie_fac, v_nro_Fac, v_year_Fac
    FROM ALBARAN_VENTAS_NC 
    WHERE NUMERO_ALBARAN = :B1.NUMERO_ALBARAN 
    AND TO_CHAR(TO_DATE(FECHA_FACTURA),'MM') = TO_CHAR(TO_DATE(:global.fecha_trabajo),'MM')
    AND EJERCICIO =  TO_NUMBER(TO_CHAR(TO_DATE(:global.fecha_trabajo),'YYYY'))
    AND NUMERO_SERIE =  :B1.NUMERO_SERIE;
    select liquido_factura into v_factura from facturas_ventas where empresa='004' and ejercicio=v_year_Fac and numero_serie= v_serie_fac and numero_factura= v_nro_Fac;
    select LIQUIDO_ALBARAN INTO V_LIQ_ALB
    from ALBARAN_VENTAS
    where empresa='004' and numero_albaran=:B1.NUMERO_ALBARAN AND NUMERO_SERIE='CAN' 
        AND EJERCICIO=TO_NUMBER(TO_CHAR(TO_DATE(:global.fecha_trabajo),'YYYY'));
    if NOT ((v_factura - ABS(v_liq_alb)) BETWEEN -0.01 AND 0.01) then 
        :p_tipo_mensaje := 'CAMPO';
        :p_codigo_mensaje := 'TEXTOLIB';
        :p_texto_mensaje := 'Valor de la factura no es igual al registro de Anulacion!!!. Valor Fact = '||v_factura ||' Valor Alb = '||abs(v_liq_alb) || ' Realizar la CORRECCION nesaria...!!!';
        :p_parar_ejecucion := 'S';
    else 
    IF :global.CODIGO_EMPRESA='004' and :B1.TIPO_PEDIDO in ('49','49A') THEN  		
        :global.id_personalizacion := '1';        	
        :p_ejecutar_programa := 'CANCFACT';        	
        :p_modo_menu_prog_llamado := 'DO_REPLACE';           	
        PKPANTALLAS.INICIALIZAR_PARAMETROS_PLUG_IN;        	
        PKPANTALLAS.PARAMETRO_PLUG_IN('PA01', 'C',:B1.ORGANIZACION_COMERCIAL);        	
        PKPANTALLAS.PARAMETRO_PLUG_IN('PA02', 'C','04');      	
        PKPANTALLAS.PARAMETRO_PLUG_IN('PA03', 'C','01');
        PKPANTALLAS.PARAMETRO_PLUG_IN('PA04', 'C',:global.fecha_trabajo);       	    	
        PKPANTALLAS.PARAMETRO_PLUG_IN('PA05', 'C',:PARAMETER.PA05);       	
        PKPANTALLAS.PARAMETRO_PLUG_IN('PA06', 'C',:PARAMETER.PA06); 
        PKPANTALLAS.PARAMETRO_PLUG_IN('PA07', 'C',:PARAMETER.PA07);  
    END IF;
    end if; 
end;

/****** codigo para cuando INICIA Programa CANCFACT ****/

IF :GLOBAL.CODIGO_EMPRESA = '004' THEN 	
	:B1.ORG_COMERCIAL:=:PARAMETER.PA01;	
    :B1.TIPO_CANCELACION:=:PARAMETER.PA02;	
    :B1.MOTIVO:=:PARAMETER.PA03;	
    :B1.FECHA_CANCELACION:=:PARAMETER.PA04;
    :B1.DESDE_NUMERO:=:PARAMETER.PA05;	
    :B1.HASTA_NUMERO:=:PARAMETER.PA05;	
    :B1.DESDE_FECHA:=:PARAMETER.PA06;	
    :B1.HASTA_FECHA:=:PARAMETER.PA06;	
    :B1.DESDE_SERIE:=:PARAMETER.PA07;	
    :B1.HASTA_SERIE:=:PARAMETER.PA07;
END IF;


PKPANTALLAS.INICIALIZAR_CODIGO_PLUG_IN;
PKPANTALLAS.COMANDO_PLUG_IN('VALIDATE', 'RECORD_SCOPE');
PKPANTALLAS.COMANDO_PLUG_IN('SYNCHRONIZE');
PKPANTALLAS.COMANDO_PLUG_IN('EXECUTE_TRIGGER', 'CONSULTAR');
PKPANTALLAS.SET_VARIABLE_ENV('V_DESMARCAR','S');

/****** fin inicio codigo  *****/

/***************************************************/
/***************************************************/
/******** LISTA DE EXECUTE_TRIGGER *******************************************/
PKPANTALLAS.COMANDO_PLUG_IN('EXECUTE_TRIGGER', 'OPCION_MENU');
pkpantallas.comando_plug_in('EXECUTE_TRIGGER','KEY-EXEQRY');
pkpantallas.comando_plug_in('EXECUTE_TRIGGER','KEY-EXIT');
PKPANTALLAS.COMANDO_PLUG_IN('EXECUTE_TRIGGER','KEY-NEXT-ITEM');
Pkpantallas.comando_plug_in('EXECUTE_TRIGGER','EJECUTAR_CONSULTA');
Pkpantallas.comando_plug_in('EXECUTE_TRIGGER','EXCEL_CMEXPED');
PKPANTALLAS.COMANDO_PLUG_IN('EXECUTE_TRIGGER','MARCAR_LOTES_ASIGNADOS');
PKPANTALLAS.COMANDO_PLUG_IN('EXECUTE_TRIGGER', 'MARCAR');


/***************************************************/
/***************************************************/
/*** codigo cuando inicia segundo bloque para ejecutar la tarea *****/

:p_tipo_mensaje := 'CAMPO';
:p_codigo_mensaje := 'TEXTOLIB';
:p_texto_mensaje := 'boton: '||:parameter.opcion_menu;
:p_parar_ejecucion := 'S';

CAMBD


if :B1.ORGANIZACION_COMERCIAL='04010' AND :PARAMETER.PA01='VTAS_DIR' then 
:parameter.opcion_menu:='B01';

PKPANTALLAS.INICIALIZAR_CODIGO_PLUG_IN;

PKPANTALLAS.COMANDO_PLUG_IN('EXECUTE_TRIGGER', 'OPCION_MENU');
PKPANTALLAS.COMANDO_PLUG_IN('VALIDATE', 'RECORD_SCOPE');
PKPANTALLAS.COMANDO_PLUG_IN('SYNCHRONIZE');
:p_tipo_mensaje := 'CAMPO';
:p_codigo_mensaje := 'TEXTOLIB';
:p_texto_mensaje := 'Boton...: '||:parameter.opcion_menu;
:p_parar_ejecucion := 'N';

:parameter.opcion_menu:='B03';
PKPANTALLAS.COMANDO_PLUG_IN('EXECUTE_TRIGGER', 'OPCION_MENU');
PKPANTALLAS.COMANDO_PLUG_IN('VALIDATE', 'RECORD_SCOPE');
PKPANTALLAS.COMANDO_PLUG_IN('SYNCHRONIZE');
:p_tipo_mensaje := 'CAMBD';
:p_codigo_mensaje := 'CAMB_OK';
:p_texto_mensaje := 'Boton-2...: '||:parameter.opcion_menu;
:p_parar_ejecucion := 'S';
end if;

/***************************************************/
/***************************************************/
/******* validar codigo *******/

      INTO v_ejecutar_programa   
      SELECT codigo, fichero_base      FROM tipos_envio_factura      WHERE codigo = v_codigo_formato;

B1.ORGANIZACION_COMERCIAL_TAB1


/****** DATA IMPORTANTE DE CODE ********/
Para gestionar el pulsado de cada uno de los botones se usará el disparador OPCION_MENU, se identificará 
el botón pulsado por el valor del parámetro OPCION_MENU.

OPCMENU.OPCION_MENU(:global.codigo_empresa, :parameter.opcion_menu);
IF :parameter.opcion_menu = ‘B01’ THEN
--CODIGO PARTICULAR PARA ESE BOTON
END IF;

-- DATO PARA EL MENU SALIR
FMENU.SALIR(<parámetro>): Botón de salir del programa
<parámetro>: Espera un valor booleano, es decir TRUE activa y FALSE desactiva



:p_tipo_mensaje := 'CAMPO';
:p_codigo_mensaje := 'TEXTOLIB';
:p_texto_mensaje := 'Valor parametro = '||:PARAMETER.PA01;
:p_parar_ejecucion := 'S';