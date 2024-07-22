select EMPRESA, codigo_cliente, NO_ASUMIR_CONDICION_PAGO_PADRE,INCLUIR_TXTFAC_ADDENDA_CFDI, PEDIR_PERSONA_PEDIDO
from clientes_parametros
where codigo_cliente in ('016826', '024688')

update clientes_parametros
set NO_ASUMIR_CONDICION_PAGO_PADRE = null , INCLUIR_TXTFAC_ADDENDA_CFDI= null, PEDIR_PERSONA_PEDIDO ='O'
where codigo_cliente = '024688' and EMPRESA ='004'

update clientes_parametros
set NO_ASUMIR_CONDICION_PAGO_PADRE = 'N' , INCLUIR_TXTFAC_ADDENDA_CFDI='N', PEDIR_PERSONA_PEDIDO ='O'
where codigo_cliente = '024688' and EMPRESA ='004'


"Data", {"Column1", "Column2", "Column3", "Column4", "Column5", "Column6", "Column7", "Column8", "Column9", "Column10", "Column11", "Column12", "Column13", "Column14", "Column15", "Column16", "Column17", "Column18", "Column19", "Column20", "Column21", "Column22", "Column23", "Column24", "Column25", "Column26", "Column27", "Column28", "Column29", "Column30", "Column31", "Column32", "Column33", "Column34", "Column35", "Column36", "Column37", "Column38", "Column39", "Column40", "Column41", "Column42", "Column43", "Column44", "Column45", "Column46"}, {"Column1", "Column2", "Column3", "Column4", "Column5", "Column6", "Column7", "Column8", "Column9", "Column10", "Column11", "Column12", "Column13", "Column14", "Column15", "Column16", "Column17", "Column18", "Column19", "Column20", "Column21", "Column22", "Column23", "Column24", "Column25", "Column26", "Column27", "Column28", "Column29", "Column30", "Column31", "Column32", "Column33", "Column34", "Column35", "Column36", "Column37", "Column38", "Column39", "Column40", "Column41", "Column42", "Column43", "Column44", "Column45", "Column46"}


 "Data", {"Lista_Columnas"})
 