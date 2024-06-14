/*** tarea 031 */
Fragmento cambiado:
if v_forma_pago in ('0200','0491') then 
	/*** valida si es pedido al contado, si es asi lo pasa directo*/
	V_RTN := pkcrmexpedientes_tareas.finalizar_tarea_at('004', :p_numero_expediente, :p_numero_linea,sysdate(),'AUTOMATICO','13',TRUE,TRUE); commit;
 else 
	V_RTN := pkcrmexpedientes_tareas.asignar_tarea_at(:global.codigo_empresa, :p_numero_expediente, :p_numero_linea, v_usuario, null, v_equipo );
	commit;
end if;

/***************/


