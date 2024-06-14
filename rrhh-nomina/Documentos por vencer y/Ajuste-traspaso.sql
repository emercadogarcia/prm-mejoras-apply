/* revision de TRASPASO DE FAMILIARES A NOMINA */

Traspaso a nomina: 
1) Tipo de empleado
2) Estado civil
Luego se debe agregar los dependientes:
 3) Cambiar tipo de relacion con la empresa = externo.
 4) Cambiar campo POR ENTERO = 2.

 -- Query que se utilizaron para ocnsultar
 
SELECT EMPRESA, CODIGO_TRABAJADOR, NOMBRE_COMPLETO,
RESERVADO_ALFA_1,IBAN_TRAB,RESERVADO_ALFA_2,RESERVADO_ALFA_3,RESERVADO_ALFA_4,RESERVADO_ALFA_5,RESERVADO_NUMBER_1, RESERVADO_NUMBER_2,RESERVADO_NUMBER_3,RESERVADO_NUMBER_4,RESERVADO_NUMBER_5
FROM rh_trabajadores
WHERE empresa = '004' 


SELECT *
from RH_TRABAJADOR_IRPF WHERE empresa = '004' and subempresa = '0401'


UPDATE RH_TRABAJADOR_IRPF
SET REG_M01='N',REG_M02='N',REG_M03='N',REG_M04='N',REG_M05='N',REG_M06='N',REG_M07='N',REG_M08='N',REG_M09='N',REG_M10='N',REG_M11='N',REG_M12='N'
WHERE empresa = '004' and subempresa = '0401' and codigo_trabajador = '00016'




