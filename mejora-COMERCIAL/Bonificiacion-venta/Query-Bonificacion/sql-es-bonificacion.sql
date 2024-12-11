
select status_linea,EJERCICIO, numero_SERIE,numero_pedido, count(*)
    from pedidos_ventas_lin 
 where empresa='004' AND ORGANIZACION_COMERCIAL='04010' and ejercicio =2024
 AND NUMERO_PEDIDO in (1849) AND NUMERO_SERIE in ('SIM') and status_linea='P'




SELECT CODIGO_CLIENTE, FECHA_BAJA, RESERVADO_DATE1, RESERVADO_DATE2, RESERVADO_DATE3, RESERVADO_DATE4
FROM DOMICILIOS_ENVIO
WHERE EMPRESA ='999' AND CODIGO_CLIENTE IN ( '017813','017936','017935','017937','017938','017813')




/******** revision query ************/


