
select status_linea,EJERCICIO, numero_SERIE,numero_pedido, count(*)
    from pedidos_ventas_lin 
 where empresa='004' AND ORGANIZACION_COMERCIAL='04010' and ejercicio =2024
 AND NUMERO_PEDIDO in (1849) AND NUMERO_SERIE in ('SIM') and status_linea='P'
