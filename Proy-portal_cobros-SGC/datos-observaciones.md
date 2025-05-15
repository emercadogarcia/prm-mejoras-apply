# SISTEMA DE GESITON DE COBROS

## Tareas requerimientos
* Agregar cliente en detalle de cobro.
* Filtro de dsashboard por usuarios.
* CRUD USUARIOS - guardar informacion de usuarios.
* Reporte o informe modelo:   FECHA COBRO | CLIENTE | DOCUMENTO | FECHA DOC| MONTO | METODO COBRO

## Presentacion herramientas.


## REUNION 08/05/2025

Estas son mis observaciones:

- Quitar los cuadritos relacionados a Lineas y poner la info relacionada a SGC

- Indicar en los cuadritos al seleccionar una factura/nota cuando es una NOTA, no solo la guía por el color y el valor negativo

- Lo mismo en el DETALLE en el COBRO, indicar si se trata de una FACTURA o NOTA.

- Corregir los usuarios, deberá completarse que esté operativo el MODIFICAR UN USUARIO

- Si el usuario es ADMINISTRADOR debería mostrar todos los cobros realizados, si no es ADMINISTRADOR debería mostrar solo los que ha realizado

- Agregar en la pantalla COBRO un filtro de fecha, por defecto el día actual, pero se puede editar para que sea por rango.

- Agregar en el listado la columna cliente (Codigo de Cliente y Nombre de Cliente).

- Modificar la columan, que diga ESTADO QR y no USUARIO

- Quitar los botones de Activar/Desactivar

- Quitar el botón eliminar

- Agregar el botón para ANULAR, anular permite:

               - Si el QR está generado, se puede revertir

               - Si el QR está pagado, no se puede revertir

               - Si es EFECTIVO o TRANSFERENCIA, si se puede revertir en cualquier escenario

- Poder visualizar el QR si me salgo de la pantalla de cobro

- Extracto de lo COBRADO por USUARIO (Por Rangos)

 ## 14/05/2025 Presentación del SGC en reunión de operaciones nacional.
SGC: Ajuste en SGC:
* Se agrega filtro para consultar cobros por rango de fecha.
* Se ajusta vista resumen: Tolal cobrado, Efectivo. QR y Transferencia y adicional los ultimos 5 cobros.
* CRUD de usuarios.
* Se agrega reporte de solo cobros del usuario llamado "Mis Cobres"
* Se agrega reporte "histórico cobros"

## link del repositorio
  https://Promedical-sa@dev.azure.com/Promedical-sa/SGC/_git/SGC

credenciales:    
usr: edgar.mercado
token: 9gRdEyHE3TwO32c8QvIj8ery6kfPH9vzsMxDSdG5bDE7IiKPsz7mJQQJ99BEACAAAAAsu1g9AAASAZDO17Pt
