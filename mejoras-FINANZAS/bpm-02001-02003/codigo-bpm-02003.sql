revisar tarea 200 envio notificacion
BOL_ANT_04

solo los que pide en el punto 5.



-- observacion PUNTO #2 *** En la secuencia de AUTORIZACION GAF solo llega solicitudes de Asignación y legalización de fondos 02001, Falta que llegue la tarea del módulo 02003 anticipo a proveedores:

HABILITAR EL EQUIPO DE APROBACION GAF 
402611 BOL - APROBADOR GAF 

-- *** PUNTO 3 *** 
Falta agregar a esta secuencia solo del modulo 02003 anticipo a proveedores al usuario de Fabiana Añez (FANEZ):
402610 BOL- VALIDACION FINANCIERA

Solucion:
Tarea 100 : se agrega linea para enivar notificacion al equipo de valiacion finannciera:

pkcrmnotificaciones.add_destinatario('EQUIPO','402610'); /* VAL. FINANCIERA*/

Tarea 360 : Se debe ACTUALIZAR el codigo a :
pkcrmnotificaciones.inicializar_destinatarios;
pkcrmnotificaciones.add_destinatario('USUARIO', v_usuario);
-- pkcrmnotificaciones.add_destinatario('USUARIO', 'EMERCADO');
-- pkcrmnotificaciones.add_destinatario('USUARIO', 'MNAVARRO');
pkcrmnotificaciones.add_destinatario('EQUIPO','403302'); /*aux contable*/
pkcrmnotificaciones.add_destinatario('EQUIPO','402610'); /*VAL. FIANNCIERA*/
--pkcrmnotificaciones.add_destinatario('USUARIO', 'JANTELO');
pkcrmnotificaciones.enviar(:global.codigo_empresa, :p_numero_expediente, :p_numero_linea, 'BOL_ANT_02');

-- *** PUNTO 4  bpm 02001***
Tarea 200: Se modifica codigo y se quita a los de finanzas, a solicitud de JANTELO:
-- NUEVO CODIGO:

REVISAR ESTE TEMA ******************* corresponde al bpm 02001. 

-- *** PUNTO 5 ***
Tarea 200: Se modifica codigo y crea nuevo equipo para enviar notificaciones solo a personal que ve anticipos
nuevo EQUIPO: 
403303  BOL - CORREO DE ANTICIPOS A EQ.CONTABLE

-- NUEVO CODIGO:
pkcrmnotificaciones.inicializar_destinatarios;
pkcrmnotificaciones.add_destinatario('USUARIO', v_usuario);
pkcrmnotificaciones.add_destinatario('USUARIO', 'SIGLESIAS');
pkcrmnotificaciones.add_destinatario('EQUIPO','403303'); /*SOLO EQ. CONTAB*/
--pkcrmnotificaciones.add_destinatario('USUARIO', 'DLOBO');
if usr='BOL_HERSIL' THEN 
  --pkcrmnotificaciones.add_destinatario('USUARIO', 'CBARROS');
  pkcrmnotificaciones.add_destinatario('USUARIO', 'JFLORES');
  end if;
pkcrmnotificaciones.enviar(:global.codigo_empresa, :p_numero_expediente, :p_numero_linea, 'BOL_ANT_04');


-- *** PUNTO 6 ***
responder en CORREO

-- *** PUNTO 7 ***
Visualizar proveedor en correo:
 -- Tarea 360 envia la notificacion:   BOL_ANT_02
 CRMEXPEDIENTES_CAB.ITEMA072
 CRMEXPEDIENTES_CAB.D_ITEMA072 ????


 select numero_expediente, ITEMA072, D_ITEMA072
FROM (SELECT crmexpedientes_CAB.*, DECODE(itema072,NULL,NULL,(SELECT p.nombre FROM proveedores p WHERE  p.codigo_rapido = crmexpedientes_cab.itema072 
and p.codigo_empresa = crmexpedientes_cab.empresa)) D_ITEMA072 FROM CRMEXPEDIENTES_CAB) X
WHERE EMPRESA='004' and tipo_expediente in ('02003')
AND numero_expediente in (747264) 

Status_tarea = '01' ==> abierto;  '999'

--- PRECARGAMOS EL DATO de los proveedores:
{SPT:PROVEEDORES:WHERE_DEFECTO:codigo_rapido = {crmexpedientes_cab.itema072} AND codigo_empresa = {crmexpedientes_cab.empresa}:SPT}

Nombre del proveedor: {PROVEEDORES.NOMBRE}
/********************************************************************/

 	SELECT codigo_secuencia, status_interno
       FROM crmexpedientes_lin
       WHERE numero_expediente = 747260
       AND empresa = '004'
	   and codigo_secuencia ='40';



/********************************************************************/
