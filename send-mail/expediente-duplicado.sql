/* Enivar email para notificar sobre expedientes con tareas duplicadas.*/

DECLARE
    html_content_inicio CLOB := '<html><style>* {font-family: sans-serif;}.content-table {border-collapse: collapse;margin: 25px 0;font-size: 0.9em; min-width: 400px;border-radius: 5px 5px 0 0;overflow: hidden;box-shadow: 0 0 20px rgba(0, 0, 0, 0.15);
    }.content-table thead tr {background-color: #28367f;color: #ffffff;text-align: left;font-weight: bold;}.content-table th,.content-table td {padding: 12px 15px;}
    .content-table tbody tr {border-bottom: 1px solid #dddddd;}.content-table tbody tr:nth-of-type(even) {background-color: #f3f3f3;
    }.content-table tbody tr:last-of-type {border-bottom: 2px solid #f80000;}.content-table tbody tr.active-row {font-weight: bold;color: #f80000;}</style><body>';

    html_content CLOB := '';
    html_content_fin CLOB := '</body></html>';
    v_resultado VARCHAR2(30);
    cursor c_exp is select numero_expediente, CODIGO_SECUENCIA, count(numero_expediente) nro_tareas  from crmexpedientes_lin where empresa='004' AND STATUS_TAREA='01'   group by numero_expediente, CODIGO_SECUENCIA HAVING count(numero_expediente)>=2;
    
BEGIN
    html_content := html_content_inicio || 'Estimado equipo de Tecnologia: <br/>A continuación se muestran los expedientes duplicados que figuran en el sistema:<hr/><table border="1" class="content-table"><thead><tr><th>Nro. expediente</th><th>Cod. Secuencia</th><th>Nro de Tareas</th> </tr></thead><tbody>';

    FOR BPM_EXP in c_exp LOOP
        
        html_content :=html_content||'<tr><td>'||TO_CHAR(BPM_EXP.NUMERO_EXPEDIENTE)||'</td><td>'||TO_CHAR(BPM_EXP.CODIGO_SECUENCIA)||'</td><td>'||TO_CHAR(BPM_EXP.nro_tareas)||'</td></tr>';
        v_resultado:='ENVIAR';
    END LOOP;
        html_content := html_content || '</tbody></table>'|| html_content_fin;
        PK_EMAIL.INICIALIZAR('BPM');
        PK_EMAIL.SET_ASUNTO('[ALERTA] EXPEDIENTES DUPLICADOS QUE REQUIEREN ATENCION');
        PK_EMAIL.SET_CUERPO_HTML(html_content);
        
        PK_EMAIL.ADD_DESTINATARIO('TO', 'soporte-ti@promedical.com.bo');

        PK_EMAIL.ADD_DESTINATARIO('CC', 'daniel.lobo@promedical.com.bo,edgar.mercado@promedical.com.bo,marcelo.osinaga@promedical.com.bo');
        --PK_EMAIL.ADD_DESTINATARIO('TO', 'edgar.mercado@promedical.com.bo');
        IF v_resultado = 'ENVIAR' THEN 
            v_resultado := PK_EMAIL.ENVIAR();
        END IF;
        html_content :='';
END;