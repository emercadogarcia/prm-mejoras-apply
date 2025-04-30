

402611  BOL - APROBADOR GAF
402610 BOL- VALIDACION FINANCIERA


 -- TAREA 360 VALIDACION FINANCIERA

 DECLARE
  v_usuario  crmexpedientes_cab.itema010%TYPE;
  v_usuario_alta  crmexpedientes_cab.itema010%TYPE;
  v_equipo crmexpedientes_lin.EQUIPO_A_REALIZARLO%TYPE;
v_cnt integer;  
v_email  VARCHAR2(100);
BEGIN
 	SELECT count(*)
       INTO v_cnt
       FROM crmexpedientes_lin
       WHERE numero_expediente = :p_numero_expediente
       AND empresa = :global.codigo_empresa
	   and codigo_secuencia ='40';
	COMMIT;   
    SELECT itema010,usuario_alta
       INTO v_usuario,v_usuario_alta
       FROM crmexpedientes_cab
       WHERE numero_expediente = :p_numero_expediente
       AND empresa = :global.codigo_empresa;  

/* se cambia la forma de autorizacion a solicitud de Gcia. Financiera, solo ellos autorizan*/
v_usuario:='YGUZMAN';
v_equipo:= '402610';
      UPDATE crmexpedientes_lin
         SET usuario_a_realizarlo = null, 
         status_interno = '0200',
         equipo_a_realizarlo = v_equipo
      WHERE numero_expediente = :p_numero_expediente
         AND numero_linea = :p_numero_linea
         AND empresa = :global.codigo_empresa;
      COMMIT;

  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      NULL;
 end;


 -- TAREA 370 APROBACION GAF
 DECLARE
  v_equipo crmexpedientes_lin.EQUIPO_A_REALIZARLO%TYPE;
v_cnt integer;  
v_email  VARCHAR2(100);
BEGIN
 	SELECT count(*)
       INTO v_cnt
       FROM crmexpedientes_lin
       WHERE numero_expediente = :p_numero_expediente
       AND empresa = :global.codigo_empresa
	   and codigo_secuencia ='40';
	COMMIT;   

/* se cambia la forma de autorizacion a solicitud de Gcia. Financiera, solo ellos autorizan*/
v_equipo:= '402611';
      UPDATE crmexpedientes_lin
         SET usuario_a_realizarlo = null, 
         status_interno = '0200',
         equipo_a_realizarlo = v_equipo
      WHERE numero_expediente = :p_numero_expediente
         AND numero_linea = :p_numero_linea
         AND empresa = :global.codigo_empresa;
      COMMIT;

  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      NULL;
 end;

 Quuita de la tare 465 bpm 02001 =dejar solo a hersil para anuncios


 -- AJUSTES AL BPM 02001
 -- *** PUNTO 4  bpm 02001***
--También hemos notado que en esta secuencia no debería llegar notificación a ninguno del área financiera, por lo que veo solo llega en solicitudes de Hersil seria que puedan revisar si algún personal de esta UEN solicito que le llegue este aviso.

Tarea 465: Se modifica codigo y se quita a los de finanzas, a solicitud de JANTELO:
*** esto fue solicitado en su momento por la gerencia general y la gerencia financiera:
-- NUEVO CODIGO:
select grupo into usr from usuarios where usuario=v_usuario AND ESTADO='BOL';
	    if usr='BOL_HERSIL' THEN 
			pkcrmnotificaciones.inicializar_destinatarios;
			--pkcrmnotificaciones.add_destinatario('USUARIO', 'CBARROS');
           --pkcrmnotificaciones.add_destinatario('EQUIPO','403302');
			--pkcrmnotificaciones.add_destinatario('USUARIO', 'SIGLESIAS');
			pkcrmnotificaciones.add_destinatario('USUARIO', 'EMERCADO');
			pkcrmnotificaciones.enviar(:global.codigo_empresa, :p_numero_expediente, :p_numero_linea, 'BOL_FR_PA2');
  		end if;
