2) Listar dni, nombre y apellido de todos los clientes ordenados por dni en forma ascendente. Realice la consulta en ambas bases. ¿Qué diferencia nota en cuanto a performance? ¿Arrojan los mismos resultados? ¿Qué puede concluir en base a las diferencias halladas?

```
reparacion:
    SELECT dniCliente, nombreApellidoCliente FROM cliente ORDER BY dniCliente ASC

reparacion_dn:
    SELECT dniCliente, nombreApellidoCliente FROM reparacion ORDER BY dniCliente ASC

Ambas tardaron 0,0000 segundos pero en reparacion_dn se repiten las tuplas.
Puedo concluir que la base reparacion esta mejor diseñada que reparacion_dn
```

3) Hallar aquellos clientes que para todas sus reparaciones siempre hayan usado su tarjeta de crédito primaria (nunca la tarjeta secundaria). Realice la consulta en ambas bases.

```
SELECT * FROM cliente WHERE NOT EXISTS (
    SELECT * FROM reparacion
    WHERE cliente.tarjetaSecundaria = reparacion.tarjetaReparacion
        AND cliente.dniCliente = reparacion.dniCliente
)
```

4) Crear una vista llamada ‘sucursalesPorCliente’ que muestre los dni de los clientes y los códigos de sucursales de la ciudad donde vive el cliente. Cree la vista en ambas bases.

```
CREATE VIEW sucursalesPorCliente AS
SELECT dniCliente, codSucursal
FROM cliente
INNER JOIN sucursal
    ON cliente.ciudadCliente = sucursal.ciudadSucursal

CREATE VIEW sucursalesPorCliente AS
SELECT dniCliente, codSucursal
FROM reparacion
WHERE ciudadCliente = ciudadSucursal
```

5) En la base normalizada, hallar los clientes que dejaron vehículos a reparar en todas las sucursales de la ciudad en la que viven
a. Realice la consulta sin utilizar la vista creada en el ej 4.
b. Realice la consulta utilizando la vista creada en el ej 4.
Restricción: resolver este ejercicio sin usar la cláusula “NOT EXIST”.
Nota: limite su consulta a los primeros 100 resultados, caso contrario el tiempo que tome puede ser excesivo.

```
a.
    SELECT * FROM cliente
    WHERE NOT EXISTS (
        SELECT * FROM sucursal
        WHERE cliente.ciudadCliente = sucursal.ciudadSucursal
        AND NOT EXISTS (
            SELECT * FROM reparacion
            WHERE cliente.dniCliente = reparacion.dniCliente
            AND reparacion.codSucursal = sucursal.codSucursal
        )
    )

    Lei que no puedo usar NOT EXIST. Matenme.

    SELECT *
    FROM cliente
    HAVING (
        SELECT COUNT(codSucursal)
        FROM sucursal
        WHERE cliente.ciudadCliente = sucursal.ciudadSucursal
        ) = (
        SELECT COUNT(sucursal.codSucursal)
        FROM reparacion
        INNER JOIN sucursal
            ON reparacion.codSucursal = sucursal.codSucursal
        WHERE cliente.ciudadCliente = sucursal.ciudadSucursal
            AND cliente.dniCliente = reparacion.dniCliente
    )

b.
    SELECT dniCliente
    FROM cliente
    WHERE (
        SELECT COUNT(codSucursal)
        FROM sucursalesPorCliente
        WHERE cliente.dniCliente = sucursalesPorCliente.dniCliente
        ) = (
        SELECT COUNT(sucursal.codSucursal)
        FROM reparacion
        INNER JOIN sucursal
            ON reparacion.codSucursal = sucursal.codSucursal
        WHERE cliente.ciudadCliente = sucursal.ciudadSucursal
            AND cliente.dniCliente = reparacion.dniCliente
    )

```

6) Hallar los clientes que en alguna de sus reparaciones hayan dejado como dato de contacto el mismo domicilio y ciudad que figura en su DNI. Realice la consulta en ambas bases.

```
SELECT *
FROM cliente
WHERE EXISTS (
    SELECT *
    FROM reparacion
    WHERE cliente.domicilioCliente = reparacion.direccionReparacionCLiente
        AND cliente.ciudadCliente = reparacion.ciudadReparacionCliente
        AND cliente.dniCliente = reparacion.dniCliente
)

SELECT DISTINCT(dniCliente)
FROM reparacion
WHERE domicilioCliente = direccionReparacionCLiente
    AND ciudadCliente = ciudadReparacionCliente

```

7) Para aquellas reparaciones que tengan registrados mas de 3 repuestos, listar el DNI del cliente, el código de sucursal, la fecha de reparación y la cantidad de repuestos utilizados. Realice la consulta en ambas bases.

```
SELECT reparacion.dniCliente, codSucursal, reparacion.fechaInicioReparacion, COUNT(repuestoReparacion)
FROM reparacion
INNER JOIN repuestoreparacion
ON reparacion.dniCliente = repuestoreparacion.dniCliente
    AND reparacion.fechaInicioReparacion = repuestoreparacion.fechaInicioReparacion
GROUP BY reparacion.dniCliente, reparacion.fechaInicioReparacion
HAVING COUNT(repuestoReparacion) > 3

SELECT dniCliente, codSucursal, fechaInicioReparacion, COUNT(DISTINCT(repuestoReparacion))
FROM reparacion
GROUP BY dniCliente, codSucursal, fechaInicioReparacion
HAVING COUNT(DISTINCT(repuestoReparacion)) > 3

```

8) Agregar la siguiente tabla:
REPARACIONESPORCLIENTE
idRC: int(11) PK AI
dniCliente: int(11)
cantidadReparaciones: int(11)
fechaultimaactualizacion: datetime
usuario: char(16)

```
```

9) Stored procedures
a) Crear un stored procedure que realice los siguientes pasos dentro de una transacción: o Realizar una consulta que para cada cliente (dniCliente), calcule la cantidad de reparaciones que tiene registradas.
    o Registrar la fecha en la que se realiza la consulta y el usuario con el que la realizó.
    o Guardar el resultado de la consulta en un cursor.
    o Iterar el cursor e insertar los valores correspondientes en la tabla REPARACIONESPORCLIENTE.
b) Ejecute el stored procedure.

```
```

10) Crear un trigger de modo que al insertar un dato en la tabla REPARACION, se actualice la cantidad de reparaciones del cliente, la fecha de actualización y el usuario responsable de la misma (actualiza la tabla REPARACIONESPORCLIENTE).

```
```

11) Crear un stored procedure que sirva para agregar una reparación, junto con una revisión de un empleado (REVISIONREPARACION) y un repuesto (REPUESTOREPARACION) relacionados dentro de una sola transacción. El stored procedure debe recibir los siguientes parámetros: dniCliente, codSucursal, fechaReparacion, cantDiasReparacion, telefonoReparacion, empleadoReparacion, repuestoReparacion.

```
```

12) Ejecutar el stored procedure del punto 11 con los siguientes datos:
dniCliente: 1009443
codSucursal: 100
fechaReparacion: 2013-12-14 12:20:31
empleadoReparacion: ‘Maidana’
repuestoReparacion: ‘bomba de combustible’
cantDiasReparacion: 4
telefonoReparacion: 4243-4255

```
```

13) Realizar las inserciones provistas en el archivo inserciones.sql. Validar mediante una consulta que la tabla REPARACIONESPORCLIENTE se esté actualizando correctamente.

```
```

14) Considerando la siguiente consulta
```
select count(r.dniCliente)
from reparacion r, cliente c, sucursal s, revisionreparacion rv
where r.dnicliente = c.dnicliente
    and r.codsucursal = s.codsucursal
    and r.dnicliente = rv.dnicliente
    and r.fechainicioreparacion = rv.fechainicioreparacion
    and empleadoreparacion = 'Maidana'
    and s.m2 < 200
    and s.ciudadsucursal = 'La Plata';
```
Analice su plan de ejecución mediante el uso de la sentencia EXPLAIN.
a) ¿Qué atributos del plan de ejecución encuentra relevantes para evaluar la performance de la consulta?
b) Observe en particular el atributo type ¿cómo se están aplicando los JOIN entre las tablas involucradas?
c) Según lo que observó en los puntos anteriores, ¿qué mejoras se pueden realizar para optimizar la consulta?
d) Aplique las mejoras propuestas y vuelva a analizar el plan de ejecución. ¿Qué cambios observa?

```
```

15) Análisis de permisos.
a) Para cada punto de la práctica incluido en el cuadro, ejecutarlo con cada uno de los usuarios creados en el punto 1 e indicar con cuáles fue posible realizar la operación.
b) Determine para cada caso, cuál es el conjunto de permisos mínimo.
c) Desde su punto de vista y contemplando lo visto en la materia, explique cuál es la manera óptima de asignar
permisos a los usuarios.

```
```
