/*** tarea 031 */
declare 
	v_forma_pago varchar2(5):=NULL;
	V_RTN VARCHAR2(10);
	v_usuario varchar2(12);
	v_equipo varchar2(12);
	v_nro_exp number;
	v_cliente varchar2(8);
	v_org varchar2(6);
	v_serie varchar2(4);
	v_numero number;
	v_ejercicio integer;
	v_cod_sec integer;

BEGIN /** codigo tarea**/
	pk_web_general.set('NUMERO_EXPEDIENTE', v_nro_exp);
	-- v_nro_exp:= :P_numero_expediente;

	IF v_nro_exp IS NULL THEN 
		v_nro_exp:= :TAREAS_MENU.NUMERO_EXPEDIENTE;
	END IF;

	SElect itema078, itema041, itema071, itemn001, itemn002
			into v_org, v_serie, v_cliente, v_ejercicio, v_numero
		from crmexpedientes_cab 
		where numero_expediente =v_nro_exp
			and empresa='004';

	--   select  forma_pago, id_crm into v_forma_pago,v_id_crm
	--         from pedidos_ventas 
	--         where empresa= :global.codigo_empresa
	--              and organizacion_comercial = :tareas_menu.c_itema078
	--              and ejercicio = :tareas_menu.c_itemn001
	--              and numero_serie= :tareas_menu.c_itema041
	--            and numero_pedido = :tareas_menu.c_itemn002;

	--  IF v_forma_pago<>'0200' OR v_forma_pago IS NULL THEN
	select  forma_pago 
		into v_forma_pago
		from pedidos_ventas 
		where empresa= '004'
			and organizacion_comercial = v_org
			and ejercicio = v_ejercicio
			and numero_serie= v_serie
			and numero_pedido = v_numero;
	--END IF;
	--commit;
		v_equipo:='402001';
		v_usuario:=:global.usuario;

	if v_forma_pago='0200' then 
		/*** valida si es pedido al contado, si es asi lo pasa directo*/

		V_RTN := pkcrmexpedientes_tareas.finalizar_tarea_at('004', :p_numero_expediente, :p_numero_linea,sysdate(),'AUTOMATICO','13',TRUE,TRUE); commit;

	else 
		V_RTN := pkcrmexpedientes_tareas.asignar_tarea_at(:global.codigo_empresa, :p_numero_expediente, :p_numero_linea, v_usuario, null, v_equipo );
		commit;
	end if;
	commit;
end;

	/**************/
	Fragmento cambiado:
	if v_forma_pago in ('0200','0491') then 
		/*** valida si es pedido al contado, si es asi lo pasa directo*/
		V_RTN := pkcrmexpedientes_tareas.finalizar_tarea_at('004', :p_numero_expediente, :p_numero_linea,sysdate(),'AUTOMATICO','13',TRUE,TRUE); commit;
	else 
		V_RTN := pkcrmexpedientes_tareas.asignar_tarea_at(:global.codigo_empresa, :p_numero_expediente, :p_numero_linea, v_usuario, null, v_equipo );
		commit;
	end if;

/***************/


/* MODIFICACION EN PEDIDOS ID=9 **/
EN EL WHERE FORMA DE PAGO:
:where_lov  AND codigo in ((select FORMA_COBRO_PAGO from CLIENTES x where x.codigo_rapido=:B1.CLIENTE AND x.codigo_empresa=:global.codigo_empresa),'0200','0491')

En campo FORMA DE PAGO se cambia codigo:
DECLARE
v number;
BEGIN
  select nvl(por_descuento_global,0) into v from clientes_parametros
    where empresa=:global.codigo_empresa and codigo_cliente=:b1.cliente;
  IF :B1.FORMA_PAGO IN ('0200','0491') THEN
    :B1.DCTO_GLOBAL:=V+6;
  ELSE
    :B1.DCTO_GLOBAL:=v;
  END IF;
END;

/************/

campo DSCTO_GLOBAL:

DECLARE
   v_max   NUMBER;
   v_clie number;
BEGIN
   SELECT nvl(RESERVADON01,0)
     INTO v_max
     FROM agentes
    WHERE     empresa = :global.codigo_empresa
          AND codigo IN (SELECT agente
  FROM agentes_clientes
 WHERE empresa = :global.codigo_empresa AND codigo_cliente = :b1.cliente);

select nvl(por_descuento_global,0) into v_clie from clientes_parametros
    where empresa=:global.codigo_empresa and codigo_cliente=:b1.cliente;
IF :B1.FORMA_PAGO in ('0200','0491') THEN
  v_max:=v_max+v_clie+3;
ELSE
  v_max:=v_max+v_clie;
end if;
   IF :B1.DCTO_GLOBAL>V_MAX
   THEN
      :p_tipo_mensaje := 'CAMPO';
      :p_codigo_mensaje := 'AUX';
      :p_texto_mensaje := 'El DESCUENTO GLOBAL (pie de Factura) no puede ser mayor al permitido al agente...!!!';
      :p_parar_ejecucion := 'S';
   END IF;
end;

/********/


DECLARE
v number :=0;
v_0 number :=0;
v_grp_user varchar2(20);
v_canalv varchar2(10);
BEGIN
pk_web_pedidos_ventas.validacion_cliente();
  select nvl(por_descuento_global,0) into v from clientes_parametros
    where empresa=:global.codigo_empresa and codigo_cliente=:cliente;
/*    SELECT RESERVADON01 into v_0 FROM AGENTES where empresa='004' and estado='BOL' AND CODIGO=
     (SELECT farma_sanibrick from va_clientes where codigo_empresa='004' and codigo_rapido=:cliente);  */
  IF :FORMA_PAGO IN  ('0200') THEN
    update CLIENTES set RESERVADON10 = v_0+v+3 where CODIGO_EMPRESA='004' and CODIGO_RAPIDO = :cliente;
  ELSE
    update CLIENTES set RESERVADON10 = v_0+v where CODIGO_EMPRESA='004' and CODIGO_RAPIDO = :cliente;
    END IF;
    SELECT grupo into v_grp_user FROM USUARIOS 
WHERE ESTADO ='BOL' AND PERFIL <>'EMPLEADO' and fbaja is null and grupo is NOT null AND USUARIO = :global.usuario;
SELECT VALOR_CLAVE into v_canalv FROM  CLIENTES_CLAVES_ESTADISTICAS c WHERE c.CLAVE='CANALV' AND c.CODIGO_CLIENTE=:CLIENTE AND c.CODIGO_EMPRESA=:global.codigo_empresa; --:empresa_activa;

IF v_canalv NOT in ('B11','B12','B15','B09') and v_grp_user in ('SUI_VISITA','SUI_ADM') THEN
  :p_tipo_mensaje := 'CAMPO';
  :p_codigo_mensaje := 'AUX';
  :p_texto_mensaje := 'No puede cargar pedidos para este cliente, debido a que no esta en el canal de ventas como PACIENTES o ACCESO!!! '||v_canalv;
  :p_parar_ejecucion := 'S';
 END IF;

END;