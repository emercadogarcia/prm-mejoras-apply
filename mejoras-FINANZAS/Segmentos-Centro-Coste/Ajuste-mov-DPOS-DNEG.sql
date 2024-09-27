/*** generar centro costo para MOV. DPOS y DNEG*/
/* este codigo se agrega */
update historico_movim_almacen hm1 set centro_coste='02030210'
where hm1.codigo_empresa='004' 
and hm1.fecha_valor BETWEEN to_date(:B1.DESDE_FECHA,'DD/MM/YYYY') and to_date(:B1.HASTA_FECHA,'DD/MM/YYYY') and hm1.codigo_movimiento in ('DNEG','DPOS');
commit;

/********* para consultar */
SELECT fecha_valor, CODIGO_MOVIMIENTO,centro_coste,CANTIDAD_UNIDAD1, importe_coste
FROM  historico_movim_almacen hm1
where hm1.codigo_empresa='004' 
and hm1.fecha_valor BETWEEN to_date('01/08/2024','DD/MM/YYYY') and to_date('31/08/2024','DD/MM/YYYY') and hm1.codigo_movimiento in ('DNEG','DPOS')
order by importe_coste desc

update historico_movim_almacen hm1 set centro_coste='02030210'
where hm1.codigo_empresa='004' 
and hm1.fecha_valor BETWEEN to_date('01/08/2024','DD/MM/YYYY') and to_date('31/08/2024','DD/MM/YYYY') and hm1.codigo_movimiento in ('DNEG','DPOS')