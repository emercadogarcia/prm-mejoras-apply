# MODIFICACION CREACION USUARIO CLIEENTE EMPLEADO
## Cambios aplicados para adecuacion bpm 10001
1. Se agrega tarea en bpm 10001. Tarea 900 Creacion d eclientes
1.1. Se Agrega ayuda para mostrar los pasos a seguir.
1.2. Se agrega botones de acciones para ingresar a consulta clietne y mostrar solicitud.
2. Se Modifica plantilla 10001 se genera copia 10001A.
3. Se genera un nuevo ID para crmexpedientes_cab para adecuar para creacion de usuarios
4. Se genera dos notificaciones para solicitud y confirmacion de creacion de cliente empleado.

## PASO A PRODUCCION
### Programa personalizacion id=5
Se pasado el programa con exito.
### Plantilla de programa 10001A
Se creado la plantilla en produccion con exito.
### Adecuacion flujo
* Se crea flujo 900 para creacion de clientes, al cual se agrega el equipo 404002 administrador de clientes
* Tarea 200 se actualza plantilla.
* Tarea 600 se quita opcion cierre.
* Tarea 800 se quita query de crear bpm. Se agrega codigo para enviar datos al usuario y al equipo de talento humano.
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
    WHERE numero_expediente = v_nro_exp
        AND empresa = :global.codigo_empresa;
    /*  EXCEPTION
        WHEN NO_DATA_FOUND THEN
        v_email := NULL; */

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
    :p_texto_mensaje := 'Datos del bpm nro_exp: '|| :p_numero_expediente ||' - '|| V_nro_exp || ', nro_lin: '|| :p_numero_linea || ', tipO: '||v_tipo;
    :p_parar_ejecucion := 'N';

    if v_tipo='NOMINA' then 
        V_RTN := pkcrmexpedientes_tareas.finalizar_tarea_at('004', :p_numero_expediente, :p_numero_linea,sysdate(),'AUTOMATICO','27T',TRUE,TRUE);
    else 
        V_RTN := pkcrmexpedientes_tareas.finalizar_tarea_at('004', :p_numero_expediente, :p_numero_linea,sysdate(),'AUTOMATICO','99',TRUE,TRUE);
    end if;
    commit;
    END;

* Se agrega tipo nde notificacion BOL_CLIE_S
* Tarea 900 se configura envio de mensaje al crear tarea. Tambien se envia notificacion al finalizar la tarea.
* Se crea notificacion BOL_AL_CTE.
