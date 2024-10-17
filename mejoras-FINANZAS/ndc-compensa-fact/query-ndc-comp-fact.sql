

SELECT - SUM((importe - NVL(importe_sustituido, 0))) AS SUMA_IMPORTES
FROM HISTORICO_COBROS
WHERE CODIGO_CLIENTE = '009264'
    AND DOCUMENTO_VIVO = 'S'
    AND IMPORTE < 0p


SELECT - SUM((importe - NVL(importe_sustituido, 0))) AS SUMA_IMPORTES
FROM HISTORICO_COBROS
WHERE CODIGO_CLIENTE = '009264'
    AND DOCUMENTO_VIVO = 'S'
    AND IMPORTE < 0

/*************   ****************/
SELECT fecha_factura, fecha_vencimiento, CODIGO_CLIENTE, documento, concepto ,SUM(importe) IMPORTE, sum(importe_cobrado) imp_cob, NVL(sum(importe_sustituido), 0) imp_sust ,  - SUM(importe - NVL(importe_sustituido, 0)- NVL(importe_cobrado, 0) ) AS SALDO
FROM HISTORICO_COBROS
WHERE DOCUMENTO_VIVO = 'S'
    AND IMPORTE < 0
group by fecha_factura, fecha_vencimiento,CODIGO_CLIENTE,  documento, concepto

WHERE CODIGO_CLIENTE = '009264'