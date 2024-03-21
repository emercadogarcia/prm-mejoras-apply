/*** ENVIO DE REPORTE POR MEDIO DE ALERTA VENTA QUINCENAL ****/
PKALRT.GRABAR_COLA_ALERTAS(p_numero_alerta => 4009, p_asunto_alerta=>'[VENTAS QQ] - AVANCE DIARIO DE VENTAS QUINCENA '||CASE WHEN TO_NUMBER(TO_CHAR(CURRENT_DATE,'DD')) < 16 THEN '1' ELSE '2' END, 
  p_notificar_mail_to => 'edgar.mercado@promedical.com.bo', p_notificar_mail_cc => 'emercadogarcia@gmail.com', p_texto_alerta_html_clob => '<font face="arial, verdana, helvetica">
        <br><b>Buenos dias:</b> <br/>
        <br>A continuacion el resumen de ventas correspondiente a la quincena ' ||CASE WHEN TO_NUMBER(TO_CHAR(CURRENT_DATE,'DD')) < 16 THEN '1' ELSE '2' END ||' del mes de '||to_char(CURRENT_DATE, 'MONTH- YYYY') ||': <br><br>
      </font>
      Region:
    <table width="640" cellspacing="1" cellpadding="4" border="0" >
        <tr>
          <td bgcolor="#F8F9F9 ">
            {GI:BOL_VENTAS_QQ:17:004:EMERCADO:P2581:HTML:466787}
          </td>
         </tr>
    </table>
    Region y Unidad de Negocio (UEN) <br/>
    <table width="640" cellspacing="1" cellpadding="4" border="0" >
        <tr>
          <td bgcolor="#F8F9F9 ">
            {GI:BOL_VENTAS_QQ:17:004:EMERCADO:P2581:HTML:466816}
            </td>
         </tr>
    </table>
    Region y Gestor de Negocios <br/>
    <table width="640" cellspacing="1" cellpadding="4" border="0" >
        <tr>
          <td bgcolor="#F8F9F9 ">
            {GI:BOL_VENTAS_QQ:17:004:EMERCADO:P2581:HTML:466821}
            </td>
         </tr>
    </table>',
    p_enviar_email =>'I' );


'QUINCENA '|| CASE WHEN TO_NUMBER(TO_CHAR(CURRENT_DATE,'DD')) < 16 THEN '1' ELSE '2' END


select to_char(CURRENT_DATE, 'MONTH-YYYY') MES 
FROM DUAL