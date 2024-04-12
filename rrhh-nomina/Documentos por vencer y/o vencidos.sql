/*rREPORTE DE DOCUEMTNOS POR VENCER */
-- Se crea nuevo reporte HEREDADO:  ==>  CASGP01-B1 Documentos por vencer y/o Vencidos RRHH [BOL]
-- cODIGO del where:
CA_DOCUMENTOS.NUMERO_REGISTRO = CA_DOCUMENTOS_REVISION.NUMERO_REGISTRO
AND CA_DOCUMENTOS_REVISION.FECHA_REVISION = (SELECT MAX(C.FECHA_REVISION) FROM CA_DOCUMENTOS_REVISION C WHERE C.NUMERO_REGISTRO = CA_DOCUMENTOS_REVISION.NUMERO_REGISTRO AND C.EMPRESA = CA_DOCUMENTOS_REVISION.EMPRESA)  AND CA_DOCUMENTOS.ORG_CALIDAD in ( '00','11') AND (CA_DOCUMENTOS_REVISION.FASE = '04' OR CA_DOCUMENTOS_REVISION.FASE = '01') AND CA_DOCUMENTOS_REVISION.FECHA_VENCIMIENTO <= trunc(sysdate)+ 90

-- nuevo where agregado:
ca_documentos_revision.empresa = '004' AND CA_DOCUMENTOS.NUMERO_REGISTRO LIKE 'RRHH%'


/** Generar codigo par enviar datos por correo */
--ENVIAR LISTA DE DOCUEMNTOS POR VENCER CAPITAL HUMANO 
PKALRT.GRABAR_COLA_ALERTAS(p_numero_alerta => 4009, p_asunto_alerta=>'[RRHH]- DOCUMENOS POR VENCER Y/O VENCIDO AL '|| CURRENT_DATE, p_notificar_mail_to => 'skarleth.ibanez@promedical.com.bo, karla.fuente@promedical.com.bo, silvia.subieta@promedical.com.bo, edson.montoya@promedical.com.bo, rossy.merida@promedical.com.bo', p_notificar_mail_cc => 'soporte.nomina@promedical.com.bo, pasante.th@promedical.com.bo', p_notificar_mail_ccO => 'edgar.mercado@promedical.com.bo', p_texto_alerta_html_clob => '<font face="arial, verdana, helvetica">
        Saludos estimado equipo de <b>Capital Humano:</b> <br/>
        <br>Me dirijo a ustedes para informarles sobre ciertos documentos que están próximos a vencer o que ya han vencido. <br><br>
        Aqui les dejo la lista:
      </font>
    <table width="640" cellspacing="1" cellpadding="4" border="0" >
        <tr>
          <td bgcolor="#E0F2F7">
            {GI:CASGP01-B1:17:004:EMERCADO:P2599:HTML:471137}
          </td>
         </tr>
    </table>', p_enviar_email =>'I');
commit;