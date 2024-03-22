/**** tra los datos requerido*/
select b.cliente, b.NUMERO_SERIE_FRA, b.numero_factura, b.ejercicio_factura, b.numero_albaran, b.numero_serie,p.numero_serie num_serie_ped, p.numero_pedido, p.ejercicio, p.numero_pedido_cliente
FROM ALBARAN_VENTAS_LIN A,albaran_ventas b, pedidos_ventas p 
WHERE a.numero_serie=b.numero_serie and a.numero_albaran=b.numero_albaran AND A.empresa=b.empresa and a.sub_albaran=b.sub_albaran AND a.ejercicio=b.ejercicio and A.NUMERO_SERIE_PEDIDO=p.numero_serie and A.numero_pedido= p.numero_pedido AND A.EJERCICIO_PEDIDO=p.ejercicio and a.organizacion_comercial=p.organizacion_comercial
and a.organizacion_comercial='04010' and b.empresa ='004' and b.EJERCICIO_FACTURA= 2024 and b.numero_factura=1 and b.NUMERO_SERIE_FRA =
group by b.cliente, b.NUMERO_SERIE_FRA, b.numero_factura, b.ejercicio_factura, b.numero_albaran, b.numero_serie, p.numero_serie , p.numero_pedido, p.ejercicio, p.numero_pedido_cliente


 /******************************/ 
select  p.numero_pedido_cliente
FROM ALBARAN_VENTAS_LIN A,albaran_ventas b, pedidos_ventas p 
WHERE a.numero_serie=b.numero_serie and a.numero_albaran=b.numero_albaran AND A.empresa=b.empresa and a.sub_albaran=b.sub_albaran AND a.ejercicio=b.ejercicio and A.NUMERO_SERIE_PEDIDO=p.numero_serie and A.numero_pedido= p.numero_pedido AND A.EJERCICIO_PEDIDO=p.ejercicio and a.organizacion_comercial=p.organizacion_comercial  and rownum =1 AND substr(HISTORICO_COBROS_TEMPORAL3.DOCUMENTO,1,3) in ('010','011','014','110','111','114','210','214','310','312','314','A10','A11','B10','B11','B14','C10','C11','C14')
and a.organizacion_comercial='04010' and b.empresa ='004' and b.EJERCICIO_FACTURA= 2024 and b.numero_factura=1 and b.NUMERO_SERIE_FRA ='210'
 
NUMERO_PEDIDO, NUMERO_SERIE_PEDIDO, EJERCICIO_PEDIDO, 

select empresa, numero_serie,ejercicio, numero_pedido, NUMERO_PEDIDO_CLIENTE
from pedidos_ventas
where empresa='004' and ejercicio =2024 and numero_pedido=3 and numero_serie ='011' 

 /******************************/ 
 HISTORICO_COBROS_TEMPORAL3.FECHA_FACTURA
 HISTORICO_COBROS_TEMPORAL3.DOCUMENTO
HISTORICO_COBROS_TEMPORAL3.CODIGO CLIENTE


-- DATO DE FACTRUA DE CARTERA PARA BUSQUEDA:
select EXTRACT(YEAR FROM FECHA_FACTURA) ejercicio, substr(DOCUMENTO,1,3) nro_serie, substr(DOCUMENTO,5,6) factura 
from HISTORICO_COBROS_TEMPORAL3
WHERE substr(DOCUMENTO,1,3) BETWEEN '010' AND '999' 

select  substr(DOCUMENTO,1,3) nro_serie, COUNT(*) CANT
from HISTORICO_COBROS_TEMPORAL3
WHERE substr(DOCUMENTO,1,3) in ('010','011','014','110','111','114','210','214','310','312','314','A10','A11','B10','B11','B14','C10','C11','C14')
GROUP BY substr(DOCUMENTO,1,3)

/*** QUERY CONSOLIDADA FINAL PARA EXTRAER DATOS DE OC CLIENTE */
MAX((select  p.numero_pedido_cliente
FROM ALBARAN_VENTAS_LIN A,albaran_ventas b, pedidos_ventas p 
WHERE a.numero_serie=b.numero_serie and a.numero_albaran=b.numero_albaran AND A.empresa=b.empresa and a.sub_albaran=b.sub_albaran AND a.ejercicio=b.ejercicio and A.NUMERO_SERIE_PEDIDO=p.numero_serie and A.numero_pedido= p.numero_pedido AND A.EJERCICIO_PEDIDO=p.ejercicio and a.organizacion_comercial=p.organizacion_comercial  and rownum =1 AND substr(HISTORICO_COBROS_TEMPORAL3.DOCUMENTO,1,3) in ('010','011','014','110','111','114','210','214','310','312','314','A10','A11','B10','B11','B14','C10','C11','C14')
and a.organizacion_comercial='04010' and b.empresa ='004' and b.EJERCICIO_FACTURA= EXTRACT(YEAR FROM HISTORICO_COBROS_TEMPORAL3.FECHA_FACTURA) and b.numero_factura= TO_NUMBER(substr(HISTORICO_COBROS_TEMPORAL3.DOCUMENTO,5,6)) and b.NUMERO_SERIE_FRA =substr(HISTORICO_COBROS_TEMPORAL3.DOCUMENTO,1,3)
))

HISTORICO_COBROS_TEMPORAL3

EXISTS (

)
'010','011','014','110','111','114','210','214','310','312','314','A10','A11','B10','B11','B14','C10','C11','C14'


A11/000626

 /******************************/ 
