/* script para determinar USUARIO */

select nif into v_usr 
from usuarIos  
where estado='BOL' AND FBAJA IS NULL and usuario=:global.usuario
 
 SELECT CODIGO_TRABAJADOR FROM RH_TRABAJADORES WHERE DNI IN (select nif from usuarIos  where estado='BOL' AND FBAJA IS NULL AND PERFIL <>'EMPLEADO')
 

/* GRUPOS DE USUARIOS EN LIBRA */
SELECT ESTADO, USUARIO,DESCRIPCION,PERFIL, grupo 
FROM USUARIOS 
WHERE ESTADO ='BOL' AND PERFIL <>'EMPLEADO' and fbaja is null and grupo is null
group by ESTADO, USUARIO,DESCRIPCION,PERFIL, grupo 

SELECT ESTADO, grupo, COUNT(*) NRO 
FROM USUARIOS 
WHERE ESTADO ='BOL' AND PERFIL <>'EMPLEADO' and fbaja is not null and grupo is NOT null
group by ESTADO, grupo 

/** PARA OBTENER LOS GRUPOS ***/
SELECT grupo FROM USUARIOS 
WHERE ESTADO ='BOL' AND PERFIL <>'EMPLEADO' and fbaja is null and grupo is NOT null AND USUARIO = 'EMERCADO'

SELECT grupo into x FROM USUARIOS 
WHERE ESTADO ='BOL' AND PERFIL <>'EMPLEADO' and fbaja is null and grupo is NOT null AND USUARIO = :global.usuario;

 /************************************************************/
-- Para obtener el canal de ventas  
SELECT VALOR_CLAVE FROM  CLIENTES_CLAVES_ESTADISTICAS c WHERE c.CLAVE='CANALV' AND c.CODIGO_CLIENTE='007339' AND c.CODIGO_EMPRESA='004'

 SELECT VALOR_CLAVE into v_canalv FROM  CLIENTES_CLAVES_ESTADISTICAS c WHERE c.CLAVE='CANALV' AND c.CODIGO_CLIENTE=:CLIENTE AND c.CODIGO_EMPRESA=:empresa_activa;

 /************************************************************/
 -- parametrizacion del codigo de control 

DECLARE
v number :=0;
v_0 number :=0;
v_grp_user varchar2(20);
v_canalv varchar2(10);
BEGIN
pk_web_pedidos_ventas.validacion_cliente();
  select nvl(por_descuento_global,0) into v from clientes_parametros
    where empresa=:global.codigo_empresa and codigo_cliente=:cliente;
/*    SELECT RESERVADON01 into v_0 FROM AGENTES where empresa='004' and estado='BOL' AND CODIGO=
     (SELECT farma_sanibrick from va_clientes where codigo_empresa='004' and codigo_rapido=:cliente);  */
  IF :FORMA_PAGO='0200' THEN
    update CLIENTES set RESERVADON10 = v_0+v+3 where CODIGO_EMPRESA='004' and CODIGO_RAPIDO = :cliente;
  ELSE
    update CLIENTES set RESERVADON10 = v_0+v where CODIGO_EMPRESA='004' and CODIGO_RAPIDO = :cliente;
    END IF;
    SELECT grupo into v_grp_user FROM USUARIOS 
WHERE ESTADO ='BOL' AND PERFIL <>'EMPLEADO' and fbaja is null and grupo is NOT null AND USUARIO = :global.usuario;
SELECT VALOR_CLAVE into v_canalv FROM  CLIENTES_CLAVES_ESTADISTICAS c WHERE c.CLAVE='CANALV' AND c.CODIGO_CLIENTE=:CLIENTE AND c.CODIGO_EMPRESA=:global.codigo_empresa; --:empresa_activa;

IF v_canalv NOT in ('B11','B12','B15') and v_grp_user in ('SUI_VISITA','SUI_ADM') THEN
  :p_tipo_mensaje := 'CAMPO';
  :p_codigo_mensaje := 'AUX';
  :p_texto_mensaje := 'No puede cargar pedidos para este cliente, debido a que no esta en el canal de ventas como PACIENTES o ACCESO!!! '||v_canalv;
  :p_parar_ejecucion := 'S';
 END IF;

END;

 /************************************************************/

 /*
  and usuario=:global.usuario);
*/
 

 /* para obtener la categoria*/
select FORMA_COBRO_PAGO
  into v_forma_pago2
from clientes
     where codigo_rapido= v_cliente and codigo_empresa='004';


/* PARA EL CANAL DE VENTAS **/
SELECT
     NOMBRE
FROM VALORES_CLAVES V
WHERE V.CLAVE   ='RPN4'
    AND V.VALOR_CLAVE=
    (
    SELECT   VALOR_CLAVE
    FROM CLIENTES_CLAVES_ESTADISTICAS c
    WHERE  c.CLAVE             ='RPN4'
           AND c.CODIGO_CLIENTE=FACTURAS_VENTAS.CLIENTE
           AND c.CODIGO_EMPRESA=facturas_ventas.empresa
                                     )
