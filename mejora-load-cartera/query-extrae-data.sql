/**** tra los datos requerido*/
select b.cliente, b.NUMERO_SERIE_FRA, b.numero_factura, b.ejercicio_factura, b.numero_albaran, b.numero_serie,p.numero_serie num_serie_ped, p.numero_pedido, p.ejercicio, p.numero_pedido_cliente
FROM ALBARAN_VENTAS_LIN A,albaran_ventas b, pedidos_ventas p 
WHERE a.numero_serie=b.numero_serie and a.numero_albaran=b.numero_albaran AND A.empresa=b.empresa and a.sub_albaran=b.sub_albaran AND a.ejercicio=b.ejercicio and A.NUMERO_SERIE_PEDIDO=p.numero_serie and A.numero_pedido= p.numero_pedido AND A.EJERCICIO_PEDIDO=p.ejercicio and a.organizacion_comercial=p.organizacion_comercial
and a.organizacion_comercial='04010' and b.empresa ='004' and b.EJERCICIO_FACTURA= 2024 and b.numero_factura=1 and b.NUMERO_SERIE_FRA =
group by b.cliente, b.NUMERO_SERIE_FRA, b.numero_factura, b.ejercicio_factura, b.numero_albaran, b.numero_serie, p.numero_serie , p.numero_pedido, p.ejercicio, p.numero_pedido_cliente


 /******************************/ 
select  p.numero_pedido_cliente
FROM ALBARAN_VENTAS_LIN A,albaran_ventas b, pedidos_ventas p 
WHERE a.numero_serie=b.numero_serie and a.numero_albaran=b.numero_albaran AND A.empresa=b.empresa and a.sub_albaran=b.sub_albaran AND a.ejercicio=b.ejercicio and A.NUMERO_SERIE_PEDIDO=p.numero_serie and A.numero_pedido= p.numero_pedido AND A.EJERCICIO_PEDIDO=p.ejercicio and a.organizacion_comercial=p.organizacion_comercial  and rownum =1 
and a.organizacion_comercial='04010' and b.empresa ='004' and b.EJERCICIO_FACTURA= 2024 and b.numero_factura=1 and b.NUMERO_SERIE_FRA ='210'
 
NUMERO_PEDIDO, NUMERO_SERIE_PEDIDO, EJERCICIO_PEDIDO, 

select empresa, numero_serie,ejercicio, numero_pedido, NUMERO_PEDIDO_CLIENTE
from pedidos_ventas
where empresa='004' and ejercicio =2024 and numero_pedido=3 and numero_serie ='011' 

 /******************************/ 
 HISTORICO_COBROS_TEMPORAL3.FECHA_FACTURA
 HISTORICO_COBROS_TEMPORAL3.DOCUMENTO
HISTORICO_COBROS_TEMPORAL3.CODIGO CLIENTE

select EXTRACT(YEAR FROM FECHA_FACTURA) ejercicio, substr(DOCUMENTO,1,3) nro_serie, substr(DOCUMENTO,5,10) factura 
from HISTORICO_COBROS_TEMPORAL3

A11/000626

 /******************************/ 
