
/************************************************************/

declare
v_nro_exp number:=null;
V_RTN VARCHAR2(10);
v_tipo varchar2(50):='VACIO';
begin 
pk_web_general.set('NUMERO_EXPEDIENTE', v_nro_exp);

 IF v_nro_exp IS NULL THEN 
	v_nro_exp:= :TAREAS_MENU.NUMERO_EXPEDIENTE;
END IF;
-- ITEMA034 guarda dato de tipo personal
	select ITEMA034
        into v_tipo
    from crmexpedientes_cab where numero_expediente =v_nro_exp
        and empresa='004';

if v_tipo='NOMINA' then 
    V_RTN := pkcrmexpedientes_tareas.finalizar_tarea_at('004', :p_numero_expediente, :p_numero_linea,sysdate(),'AUTOMATICO','27T',TRUE,TRUE);
else 
    V_RTN := pkcrmexpedientes_tareas.finalizar_tarea_at('004', :p_numero_expediente, :p_numero_linea,sysdate(),'AUTOMATICO','99',TRUE,TRUE);
end if;
commit;
end;

/*****************************/

:p_tipo_mensaje := 'CAMPO';
:p_codigo_mensaje := 'TEXTOLIB';
:p_texto_mensaje := 'Esta intentado duplicar la tarea, cancele esta operacion, o contactese con el area de SISTEMAS ' + TO_CHAR(v_cod_sec);
:p_parar_ejecucion := 'N';


/***** modificacion TAREA 800 BPM 10001 *****/
DECLARE
  v_email crmexpedientes_cab.itema062%TYPE;
  v_nro_exp number:=null;
  V_RTN VARCHAR2(10);
  v_tipo crmexpedientes_cab.itema034%TYPE:='VACIO';
BEGIN
  pk_web_general.set('NUMERO_EXPEDIENTE', v_nro_exp);

  IF v_nro_exp IS NULL THEN 
  	v_nro_exp:= :TAREAS_MENU.NUMERO_EXPEDIENTE;
  END IF;
  SELECT itema062, ITEMA034
    INTO v_email, v_tipo
  FROM crmexpedientes_cab
  WHERE numero_expediente = :p_numero_expediente
     AND empresa = :global.codigo_empresa;

   pkcrmnotificaciones.inicializar_destinatarios;
  IF v_email IS NOT NULL THEN
    pkcrmnotificaciones.add_destinatario('EMAIL', v_email);
  END IF;
 --    pkcrmnotificaciones.add_destinatario('EQUIPO', '408100'); equipo de Tecnologia
 -- pkcrmnotificaciones.add_destinatario('EQUIPO', '430003');    EQUIPO TALENTO HUMANO
  pkcrmnotificaciones.add_destinatario('EMAIL', 'EDGAR.MERCADO@promedical.com.bo');
  pkcrmnotificaciones.enviar(:global.codigo_empresa, :p_numero_expediente, :p_numero_linea, 'BOL_ACC_02');
 :p_tipo_mensaje := 'CAMPO';
 :p_codigo_mensaje := 'TEXTOLIB';
 :p_texto_mensaje := 'Datos del bpm nro_exp: '|| :p_numero_expediente || ', nro_lin: '|| :p_numero_linea || ', tiop: '||v_tipo;
 :p_parar_ejecucion := 'N';

 if v_tipo='NOMINA' then 
    V_RTN := pkcrmexpedientes_tareas.finalizar_tarea_at('004', :p_numero_expediente, :p_numero_linea,sysdate(),'AUTOMATICO','27T',TRUE,TRUE);
 else 
    V_RTN := pkcrmexpedientes_tareas.finalizar_tarea_at('004', :p_numero_expediente, :p_numero_linea,sysdate(),'AUTOMATICO','99',TRUE,TRUE);
 end if;
commit;
END;



 :p_tipo_mensaje := 'CAMPO';
 :p_codigo_mensaje := 'TEXTOLIB';
 :p_texto_mensaje := 'Pasos que deben seguir: 
1. Ingresar a la empresa PARAGUAS.
2. Ingresar a prg CLIENTES y crear nuevo cliente.
3. Salir de PARAGUAS e ingresar a emp. BOLIVIA.
4. Actulizar de los datos del cliente nuevo.';
 :p_parar_ejecucion := 'N';

1. Debe ingresar a Libra a la empresa PARAGUAS.
2. Ingresar al programa CLIENTES y crear el cliente con los datos basicos.
3. Salir de PARAGUAS e ingresar a empresa BOLIVIA luego acceder al programa CLIENTES.
4. Hacer la actulizacion de los datos del cliente nuevo.
5. Finalizar el BPM para que comunique autmoaticamente la creacion del clente.