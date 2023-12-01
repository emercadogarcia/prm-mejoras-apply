-- revision de codigo de mejora
/* tarea 020 CONFIRMAR PEDIDO*/
DECLARE
  v_status varchar2(10):=null ; V_RTN VARCHAR2(5); v_fin varchar2(5); v_fecha varchar2(10); v_almacen varchar2(10);v_dias integer; v_tipo_ped varchar2(5); v_cta_nom integer; v_cliente varchar2(20); v_year number; v_serie varchar2(3); v_ped number;v_cod_sec integer;
begin
if :GLOBAL.CODIGO_EMPRESA='004' THEN 
select status_pedido, tipo_pedido, almacen_pedido, cliente , ejercicio,numero_serie, numero_pedido
    into v_status, v_tipo_ped, v_almacen, v_cliente,v_year, v_serie, v_ped
	from pedidos_ventas 
  where empresa= '004' 
  and organizacion_comercial = :tareas_menu.c_itema078 
	and ejercicio = :tareas_menu.c_itemn001 
  and numero_serie= :tareas_menu.c_itema041 and numero_pedido = :tareas_menu.c_itemn002;  
	select NVL(count(codigo_rapido),0) into v_cta_nom 
	from va_clientes where codigo_rapido = v_cliente and codigo_empresa = '004' and tipo_cliente = 'B17';
	if to_number(v_status) < 500 and v_tipo_ped not like '2%' AND v_cta_nom=0 then
		select DECODE(FECHA_BLOQUEO_PLAZO,NULL,'NULO',FECHA_BLOQUEO_PLAZO) into v_fecha from va_clientes where codigo_empresa= '004' and codigo_rapido = v_cliente;
			if v_fecha = 'NULO' then
				v_fin :='81';
			else
				v_dias :=round(to_number(sysdate() - to_date(v_fecha,'DD/MM/YYYY')),0);
				if  v_dias < 31 then
					v_fin :='81';
				else
					if v_dias >30 and v_dias<91 then
						v_fin := '81A';
					end if;
					if v_dias >90  then
						v_fin := '81B';
					end if;
				end if;
			end if;					
	else
		--if to_number(v_status) < 500 then
		if v_tipo_ped like '2%' then
				update pedidos_ventas  set
				status_pedido= '1000'
				where empresa= '004' and organizacion_comercial = '04010' and ejercicio = v_year
				and numero_serie= v_serie and numero_pedido = v_ped;
				commit;
        v_fin:= '81C';
		else
			if v_cta_nom <= 0 then
				if to_number(v_status) >= 500 then
					v_fin := '31';
				end if;
			else
				if 	v_almacen = '04010' then
						v_fin := '31C';
				end if;
				if v_almacen = '04011' or v_almacen = '04013' then
						v_fin := '31D';
				end if;
				if v_almacen = '04014' or v_almacen = '04017' then
						v_fin := '31E';
				end if;
			end if;
		end if;
	end if; 
select nvl(max(count(*)),0) into v_cod_sec  
from crmexpedientes_lin where empresa=:global.codigo_empresa and numero_expediente = :p_numero_expediente and codigo_secuencia in ('030','031','032','033','034','040','050','070')
group by numero_expediente, CODIGO_SECUENCIA;
if v_cod_sec < 1 then
V_RTN := pkcrmexpedientes_tareas.finalizar_tarea_at('004', :p_numero_expediente,:p_numero_linea,sysdate(),:global.usuario,v_fin,TRUE,TRUE);	
else
:p_tipo_mensaje := 'CAMPO';
:p_codigo_mensaje := 'TEXTOLIB';
:p_texto_mensaje := 'Esta intentado duplicar la tarea, cancele esta operacion, o contactese con el area de SISTEMAS ' + TO_CHAR(v_cod_sec);
:p_parar_ejecucion := 'S';
end if;
COMMIT;
END IF;
EXCEPTION WHEN NO_DATA_FOUND THEN
  NULL;
END;
/**********************************************************/


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

BEGIN
--IF :tareas_menu.c_itema078 = '04010' THEN

v_nro_exp:= :P_numero_expediente;
 IF v_nro_exp IS NULL THEN 
	v_nro_exp:= :p_numero_expediente;
END IF;
	select itema078, itema041, itema071, itemn001, itemn002
        into v_org, v_serie, v_cliente, v_ejercicio, v_numero
    from crmexpedientes_cab where numero_expediente =v_nro_exp
        and empresa='004';

--   select  forma_pago, id_crm into v_forma_pago,v_id_crm
--         from pedidos_ventas 
--         where empresa= :global.codigo_empresa
--              and organizacion_comercial = :tareas_menu.c_itema078
--              and ejercicio = :tareas_menu.c_itemn001
--              and numero_serie= :tareas_menu.c_itema041
--            and numero_pedido = :tareas_menu.c_itemn002;

--  IF v_forma_pago<>'0200' OR v_forma_pago IS NULL THEN
  select  forma_pago into v_forma_pago
    from pedidos_ventas 
    where empresa= :global.codigo_empresa
        and organizacion_comercial = v_org
        and ejercicio = v_ejercicio
        and numero_serie= v_serie
        and numero_pedido = v_numero;
  --END IF;
--commit;
	v_equipo:='402001';
	v_usuario:=:global.usuario;

if v_forma_pago='0200' then 
/*	pkcrmnotificaciones.inicializar_destinatarios;
	pkcrmnotificaciones.add_destinatario('EMAIL', 'edgar.mercado@promedical.com.bo');
	pkcrmnotificaciones.enviar(:global.codigo_empresa, :p_numero_expediente, :p_numero_linea, 'BOL_PRUEBA');  
	COMMIT;   */
	/*** valida si es pedido al contado, si es asi lo pasa directo*/

	V_RTN := pkcrmexpedientes_tareas.finalizar_tarea_at('004', :p_numero_expediente, :p_numero_linea,sysdate(),'AUTOMATICO','13',TRUE,TRUE);

 else 
	V_RTN := pkcrmexpedientes_tareas.asignar_tarea_at(:global.codigo_empresa, :p_numero_expediente, :p_numero_linea, v_usuario, null, v_equipo );
end if;
 commit;
end;


/****tatea 060 - liberar pedido ******/
declare 
v_rdo varchar2(6) := 'S';
V_CNT INTEGER;
V_ID_CRM VARCHAR2(10);
V_AUTORIZADOR  VARCHAR2(20);
user_alta varchar2(15);
grupo_user varchar2(15);
v_cod_sec integer;
begin

select COUNT(*) INTO V_CNT from AUTORIZADORES WHERE USUARIO= :GLOBAL.USUARIO AND STATUS_BLOQUEO ='N'  AND(FECHA_VALIDEZ IS NULL OR FECHA_VALIDEZ > TRUNC(SYSDATE)) AND USAR_EN_VENTAS='S';

IF V_CNT >0 THEN
select MAX(CODIGO_AUTORIZADOR) INTO V_AUTORIZADOR from AUTORIZADORES WHERE USUARIO= :GLOBAL.USUARIO AND STATUS_BLOQUEO ='N' 
AND (FECHA_VALIDEZ IS NULL OR FECHA_VALIDEZ > TRUNC(SYSDATE)) AND USAR_EN_VENTAS='S' ;

END IF;
grupo_user:='';
SELECT usuario_alta,grupo into user_alta,grupo_user from (SELECT crmexpedientes_CAB.*,(SELECT GRUPO FROM USUARIOS WHERE usuario=crmexpedientes_cab.usuario_alta ) GRUPO FROM crmexpedientes_CAB) crmexpedientes_cab where empresa = :global.codigo_empresa and numero_expediente =:p_numero_expediente;
if SUBSTR(grupo_user,1,3)='POP' THEN

  V_AUTORIZADOR := pkcrmexpedientes_tareas.finalizar_tarea_AT(:global.codigo_empresa, :p_numero_expediente,:p_numero_linea,sysdate(),:global.usuario,'81Z',TRUE,TRUE);
   /* commit;   Se quita _AT y agrega commit */

ELSE

   V_AUTORIZADOR := pkcrmexpedientes_tareas.finalizar_tarea_AT(:global.codigo_empresa, :p_numero_expediente,:p_numero_linea,sysdate(),:global.usuario,'99',TRUE,TRUE);
    /*commit;   Se quita _AT y agrega commit */

END IF;
commit;
end ;



/**** tarea 070 - emitir pedido ********/

DECLARE
  v_usuario  crmexpedientes_cab.usuario_alta%TYPE;
  v_equipo  crmexpedientes_lin.equipo_a_realizarlo%TYPE;
  n_linea  crmexpedientes_lin.numero_linea%TYPE;
  v_status varchar2(10);
  V_RTN VARCHAR2(5);
 v_bodega varchar2(10) :=null ;
 v_nro_serie varchar2(5);
 v_nro_ped number;
 v_year number;
 v_cod_sec integer;
BEGIN

if :c_itema078 = '04010' THEN
       v_equipo:='VACIO';
 else
       v_equipo:='WLSISTEMA';
 END IF;

 select almacen_entrega,numero_serie,numero_pedido,ejercicio 
    into v_bodega, v_nro_serie,v_nro_ped,v_year
    from pedidos_ventas 
    where empresa= :global.codigo_empresa
        and organizacion_comercial = :tareas_menu.c_itema078
        and ejercicio = :tareas_menu.c_itemn001
        and numero_serie= :tareas_menu.c_itema041
        and numero_pedido = :tareas_menu.c_itemn002;
  IF  v_bodega is null THEN
      select almacen_entrega,numero_serie,numero_pedido,ejercicio 
      into v_bodega, v_nro_serie,v_nro_ped,v_year
      from pedidos_ventas 
      where empresa= :global.codigo_empresa
          and organizacion_comercial = :c_itema078
          and ejercicio = :c_itemn001
          and numero_serie= :c_itema041
          and numero_pedido = :c_itemn002;
  END IF;
  select equipo 
  into v_equipo 
  from crmequipos 
  where substr(descripcion,1,5)= v_bodega 
          and substr(equipo,3,2)='20'
          and empresa= :global.codigo_empresa;

	IF substr(v_bodega,1,5) ='04017'  then 
      v_equipo:='402004';
  END IF;        

UPDATE PEDIDOS_VENTAS
SET STATUS_PEDIDO='1000'
where empresa='004' 
  and NUMERO_PEDIDO =v_nro_ped 
  and numero_serie= v_nro_serie 
  AND EJERCICIO=v_year 
  and organizacion_comercial = '04010'
  and status_pedido< '999';
COMMIT;
select max(codigo_secuencia) cod_sec
  into v_status
  from crmexpedientes_lin 
  where empresa='004' 
  and numero_expediente = :p_numero_expediente
  AND STATUS_TAREA='01';
if v_status = '070' then 

  V_RTN := pkcrmexpedientes_tareas.finalizar_tarea_at('004', :p_numero_expediente, :p_numero_linea,sysdate(),'AUTOMATICO','99',TRUE,TRUE); 

  commit;
end if;
select max(numero_linea) n, max(codigo_secuencia) cod_sec 
  into n_linea, v_status
  from crmexpedientes_lin 
  where empresa='004' 
  and numero_expediente = :p_numero_expediente 
  and codigo_secuencia='075' 
  AND STATUS_TAREA='01';
  if v_status = '075' then 
    V_RTN := pkcrmexpedientes_tareas.asignar_tarea(:global.codigo_empresa, :p_numero_expediente, n_linea, 'AUTOMATICO', null, v_equipo);
  end if;
 COMMIT;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
      NULL;
END;