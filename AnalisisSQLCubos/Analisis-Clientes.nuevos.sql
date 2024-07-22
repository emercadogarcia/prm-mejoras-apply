select sum(IMP_FACTURADO) IMP_FACTURADO, sum(cantidad) cantidad
from bol_bi_vtas_ppto where ejercicio='2020' and v_mes=5 and cliente_id =

/* analizar clientes nuevos por mes*/
select codigo_rapido,nombre,razon_social, provincia, usuario_alta, FECHA_ALTA, extract( year from fecha_alta) year,  extract(month from fecha_alta) mes, (select sum(IMP_FACTURADO) x from bol_bi_vtas_ppto where ejercicio= extract(year from clientes.fecha_alta) and v_mes=extract(month from clientes.fecha_alta) and cliente_id =clientes.codigo_rapido
) IMP_FACTURADO
from clientes 
where codigo_empresa='004' 
and extract(year from fecha_alta) in (2021,2022,2023,2024)

