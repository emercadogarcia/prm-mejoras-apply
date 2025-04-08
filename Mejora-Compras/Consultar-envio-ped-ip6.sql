SELECT *
FROM suco_ip6_pc ip
WHERE ip.numero_pedido >= 245
   AND ip.serie_numeracion = '07'
  AND ip.organizacion_compras = '04017'
  AND ip.codigo_empresa = '004'

/** reenviar PEDIDO COMPRAS desde LIBRA a IP6 ****/

DELETE 
FROM suco_ip6_pc ip
WHERE ip.numero_pedido = 248
   AND ip.serie_numeracion = '07'
  AND ip.organizacion_compras = '04017'
  AND ip.codigo_empresa = '004'

/******* ********/
select *
from suco_ip6_clientes 
where 