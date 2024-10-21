/******** datos clientes PDV */

-- OBTENER CATEGORIA
(SELECT REPLACE(tipos_cliente.descripcion,'CATEGORÍA ','')
          FROM TIPOS_CLIENTE
          WHERE tipos_cliente.codigo=CLIENTES.TIPO_CLIENTE)



AND CASE WHEN :F_CLIENTE_ACTIVO ='S' THEN (CLIENTES.FECHA_BAJA IS NULL) 
    ELSE (CLIENTES.FECHA_BAJA IS NOT NULL)

AND CLIENTES.FECHA_BAJA IS (CASE WHEN :F_CLIENTE_ACTIVO ='S' THEN NULL ELSE NOT NULL)

(CASE WHEN CLIENTES.FECHA_BAJA IS NULL THEN 'S' ELSE 'N' END)

/* para extrar se utilizo el reporte de clientes y direcciones de envio. */

codigo_articulo, NUMERO_BARRAS
(select MAX(NUMERO_BARRAS) from codigos_barras
where codigo_empresa =ARTICULOS.CODIGO_EMPRESA and codigo_articulo =ARTICULOS.CODIGO_ARTICULO)

