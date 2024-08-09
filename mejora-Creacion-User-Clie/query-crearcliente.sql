/******** bpm 04005 tarea 100 */
declare
v_paso varchar2(10);
v_depto varchar2(5);
V_CODIGO VARCHAR2(10);
v_nombre varchar2(40);
v_cnt1 integer;
begin
select count(*) into v_cnt1 from crmexpedientes_cab where empresa = :global.codigo_empresa and numero_expediente = :p_numero_expediente and itema071 is not null;
if v_cnt1 = 0 then
v_codigo:= PKPANTALLAS.SIGUIENTE_CODIGO_CONTADOR('999', 'CLI', NULL, NULL, 6)   ;
SELECT COMUNIDAD_AUTONOMA into v_depto FROM PROVINCIAS WHERE ESTADO=  :tareas_menu.c_itema017 AND PROVINCIA=  :tareas_menu.c_itema020;
 SUCO_CREA_CLIENTE(:global.codigo_empresa, V_CODIGO , :tareas_menu.c_itema003,substr(:tareas_menu.c_descripcion_expediente1,1,40), :tareas_menu.c_itema017, 'C01', :tareas_menu.c_descripcion_expediente2, :tareas_menu.c_itema020, ' ', 'NDEF', 'SIN', v_DEPTO ,'COC11', :tareas_menu.c_agente, :tareas_menu.c_comentarios004, :tareas_menu.c_itema062, :tareas_menu.c_itema063, :tareas_menu.c_itemn024,:tareas_menu.c_itema062, :tareas_menu.c_itema041, :tareas_menu.c_comentarios003);

update crmexpedientes_cab set itema071= v_codigo where empresa = :global.codigo_empresa and numero_expediente = :p_numero_expediente;

COMMIT;
else
:p_tipo_mensaje := 'CAMPO';
:p_codigo_mensaje := 'TEXTOLIB';
:p_texto_mensaje := 'Este Cliente ya se ha Creado con el Codigo indicado en la parte Inferior, continue con el proceso para realizar consulta y modificaciones de ser requerido';
:p_parar_ejecucion := 'S';
end if;

end;
/*******************/