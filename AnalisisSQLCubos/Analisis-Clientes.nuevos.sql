select sum(IMP_FACTURADO) IMP_FACTURADO, sum(cantidad) cantidad
from bol_bi_vtas_ppto where ejercicio='2020' and v_mes=5

