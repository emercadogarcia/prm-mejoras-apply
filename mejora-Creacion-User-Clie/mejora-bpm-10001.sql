
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
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      v_email := NULL;

   pkcrmnotificaciones.inicializar_destinatarios;
  IF v_email IS NOT NULL THEN
    pkcrmnotificaciones.add_destinatario('EMAIL', v_email);
  END IF;
 --    pkcrmnotificaciones.add_destinatario('EQUIPO', '408100'); equipo de Tecnologia
 -- pkcrmnotificaciones.add_destinatario('EQUIPO', '430003');    EQUIPO TALENTO HUMANO
  pkcrmnotificaciones.add_destinatario('EMAIL', 'EDGAR.MERCADO@promedical.com.bo');
  pkcrmnotificaciones.enviar(:global.codigo_empresa, :p_numero_expediente, :p_numero_linea, 'BOL_ACC_02');
 if v_tipo='NOMINA' then 
    V_RTN := pkcrmexpedientes_tareas.finalizar_tarea_at('004', :p_numero_expediente, :p_numero_linea,sysdate(),'AUTOMATICO','27T',TRUE,TRUE);
 else 
    V_RTN := pkcrmexpedientes_tareas.finalizar_tarea_at('004', :p_numero_expediente, :p_numero_linea,sysdate(),'AUTOMATICO','99',TRUE,TRUE);
 end if;
commit;
END;
