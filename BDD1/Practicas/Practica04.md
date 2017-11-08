# Practica 4 - SQL.

## Ejercicio 2.

Listar dni, nombre y apellido de todos los clientes ordenados por dni en forma ascendente. Realice la consulta en ambas bases. ¿Qué diferencia nota en cuanto a performance? ¿Arrojan los mismos resultados? ¿Qué puede concluir en base a las diferencias halladas?

```sql
reparacion:
    SELECT dniCliente, nombreApellidoCliente
    FROM cliente
    ORDER BY dniCliente ASC

reparacion_dn:
    SELECT dniCliente, nombreApellidoCliente
    FROM reparacion
    ORDER BY dniCliente ASC

En reparacion_dn se repiten las tuplas. Para evitarlo deberia ejecutar la siguiente consulta:

reparacion_dn:
    SELECT DISTINCT dniCliente, nombreApellidoCliente
    FROM reparacion
    ORDER BY dniCliente ASC

La consulta de reparacion tarda menos que cualquiera de las dos consultas de reparacion_dn
Puedo concluir que la base reparacion esta mejor diseñada que reparacion_dn
```

--------------------------------------------------------------------------------

### Ejercicio 3.

Hallar aquellos clientes que para todas sus reparaciones siempre hayan usado su tarjeta de crédito primaria (nunca la tarjeta secundaria). Realice la consulta en ambas bases.

```sql

reparacion:
    SELECT *
    FROM cliente
    WHERE NOT EXISTS (
        SELECT * FROM reparacion
        WHERE cliente.tarjetaSecundaria = reparacion.tarjetaReparacion
            AND cliente.dniCliente = reparacion.dniCliente
    )

reparacion_dn:
    SELECT DISTINCT dniCliente
    FROM reparacion as r
    WHERE NOT EXISTS (
        SELECT DISTINCT reparacion.dniCliente
        FROM reparacion
        WHERE r.dniCliente = reparacion.dniCliente
            AND r.tarjetaSecundaria = reparacion.tarjetaReparacion
    )
```

--------------------------------------------------------------------------------

### Ejercicio 4.

Crear una vista llamada 'sucursalesPorCliente' que muestre los dni de los clientes y los códigos de sucursales de la ciudad donde vive el cliente. Cree la vista en ambas bases.

```sql
CREATE VIEW sucursalesPorCliente AS
SELECT dniCliente, codSucursal
FROM cliente
INNER JOIN sucursal
    ON cliente.ciudadCliente = sucursal.ciudadSucursal
GROUP BY dniCliente, codSucursal

CREATE VIEW sucursalesPorCliente AS
SELECT dniCliente, codSucursal
FROM reparacion
WHERE ciudadCliente = ciudadSucursal
GROUP BY dniCliente, codSucursal
```

--------------------------------------------------------------------------------

### Ejercicio 5.

En la base normalizada, hallar los clientes que dejaron vehículos a reparar en todas las sucursales de la ciudad en la que viven

- Realice la consulta sin utilizar la vista creada en el ej 4.
- Realice la consulta utilizando la vista creada en el ej 4.

Restricción: resolver este ejercicio sin usar la cláusula "NOT EXIST".

Nota: limite su consulta a los primeros 100 resultados, caso contrario el tiempo que tome puede ser excesivo.

```sql
a.
    SELECT *
    FROM cliente
    WHERE (
        SELECT COUNT(codSucursal)
        FROM sucursal
        WHERE cliente.ciudadCliente = sucursal.ciudadSucursal
    ) = (
        SELECT COUNT(DISTINCT sucursal.codSucursal))
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
        SELECT COUNT(DISTINCT sucursal.codSucursal))
        FROM reparacion
        INNER JOIN sucursal
            ON reparacion.codSucursal = sucursal.codSucursal
        WHERE cliente.ciudadCliente = sucursal.ciudadSucursal
            AND cliente.dniCliente = reparacion.dniCliente
    )
```

Los resultados de estas consultas incluyen los clientes que no tienen ninguna sucursal en su ciudad.

--------------------------------------------------------------------------------

### Ejercicio 6.

Hallar los clientes que en alguna de sus reparaciones hayan dejado como dato de contacto el mismo domicilio y ciudad que figura en su DNI. Realice la consulta en ambas bases.

```sql
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

--------------------------------------------------------------------------------

### Ejercicio 7.

Para aquellas reparaciones que tengan registrados mas de 3 repuestos, listar el DNI del cliente, el código de sucursal, la fecha de reparación y la cantidad de repuestos utilizados. Realice la consulta en ambas bases.

```sql
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

--------------------------------------------------------------------------------

### Ejercicio 8.

Agregar la siguiente tabla:

```
REPARACIONESPORCLIENTE
idRC: int(11) PK AI
dniCliente: int(11)
cantidadReparaciones: int(11)
fechaultimaactualizacion: datetime
usuario: char(16)
```

```sql
CREATE TABLE reparacionesporcliente (
    idRC int(11) PRIMARY KEY AUTO_INCREMENT,
    dniCliente int(11) NOT NULL,
    cantidadReparaciones int(11) NOT NULL,
    fechaultimaactualizacion datetime NOT NULL,
    usuario char(16) NOT NULL
);
```

--------------------------------------------------------------------------------

### Ejercicio 9.

Stored procedures

a) Crear un stored procedure que realice los siguientes pasos dentro de una transacción: o Realizar una consulta que para cada cliente (dniCliente), calcule la cantidad de reparaciones que tiene registradas.

- Registrar la fecha en la que se realiza la consulta y el usuario con el que la realizó.
- Guardar el resultado de la consulta en un cursor.
- Iterar el cursor e insertar los valores correspondientes en la tabla REPARACIONESPORCLIENTE.

b) Ejecute el stored procedure.

```sql
CREATE PROCEDURE punto9()
BEGIN

    DECLARE done INT DEFAULT FALSE;
    DECLARE cant INT;
    DECLARE dni INT;
    DECLARE cur CURSOR FOR
        SELECT count(*), dniCliente
        FROM reparacion
        GROUP BY dniCliente;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    START TRANSACTION;
        OPEN cur;
        loop_1: LOOP
            FETCH cur INTO cant, dni;
            IF done THEN
                LEAVE loop_1;
            END IF;
            INSERT INTO REPARACIONESPORCLIENTE (dniCliente, cantidadReparaciones, fechaultimaactualizacion, usuario)
            VALUES (dni, cant, NOW(), CURRENT_USER);
        END LOOP;
        CLOSE cur;
    COMMIT;
END;

b)  CALL punto9()
```

--------------------------------------------------------------------------------

### Ejercicio 10.

Crear un trigger de modo que al insertar un dato en la tabla REPARACION, se actualice la cantidad de reparaciones del cliente, la fecha de actualización y el usuario responsable de la misma (actualiza la tabla REPARACIONESPORCLIENTE).

```sql
CREATE TRIGGER after_reparacion_insert
    AFTER INSERT ON reparacion
    FOR EACH ROW BEGIN

    IF (NEW.dniCliente IN (SELECT dniCliente FROM reparacionesporcliente)) THEN
        UPDATE reparacionesporcliente
        SET cantidadReparaciones = cantidadReparaciones + 1,
            fechaultimaactualizacion = NOW(), usuario = CURRENT_USER()
        WHERE NEW.dniCliente = reparacionesporcliente.dniCliente;
    ELSE
        INSERT INTO reparacionesporcliente
        (dniCliente, cantidadReparaciones, fechaultimaactualizacion, usuario)
        VALUES (NEW.dniCliente, 1, NOW(), CURRENT_USER());
    END IF;
END;
```

--------------------------------------------------------------------------------

### Ejercicio 11.

Crear un stored procedure que sirva para agregar una reparación, junto con una revisión de un empleado (REVISIONREPARACION) y un repuesto (REPUESTOREPARACION) relacionados dentro de una sola transacción. El stored procedure debe recibir los siguientes parámetros: dniCliente, codSucursal, fechaReparacion, cantDiasReparacion, telefonoReparacion, empleadoReparacion, repuestoReparacion.

```sql
CREATE PROCEDURE punto11(IN dni INT(11), IN sucursal INT, IN fechaReparacion DATETIME, IN dias INT, IN tel VARCHAR(45), IN empleado VARCHAR(30), IN repuesto VARCHAR(30))
BEGIN

    DECLARE domicilio VARCHAR(255);
    DECLARE ciudad VARCHAR(255);
    DECLARE tarjeta VARCHAR(255);

    SELECT domicilioCliente, ciudadCliente, tarjetaPrimaria INTO domicilio, ciudad, tarjeta FROM cliente WHERE cliente.dniCliente = dni;

    START TRANSACTION;
        INSERT INTO reparacion (codSucursal, dniCliente, fechaInicioReparacion, cantDiasReparacion, telefonoReparacionCliente, direccionReparacionCliente, ciudadReparacionCliente, tarjetaReparacion)
        VALUES (sucursal, dni, fechaReparacion, dias, tel, domicilio, ciudad, tarjeta);

        INSERT INTO revisionreparacion (dniCliente, fechaInicioReparacion, empleadoReparacion)
        VALUES (dni, fechaReparacion, empleado);

        INSERT INTO repuestoreparacion (dniCliente, fechaInicioReparacion, repuestoReparacion)
        VALUES (dni, fechaReparacion, repuesto);
    COMMIT;
END;
```

--------------------------------------------------------------------------------

### Ejercicio 12.

Ejecutar el stored procedure del punto 11 con los siguientes datos:

```
dniCliente: 1009443
codSucursal: 100
fechaReparacion: 2013-12-14 12:20:31
empleadoReparacion: ‘Maidana’
repuestoReparacion: ‘bomba de combustible’
cantDiasReparacion: 4
telefonoReparacion: 4243-4255
```

```sql
CALL punto11(1009443, 100, 2013-12-14 12:20:31, 4, '4243-4255', 'Maidana', 'bomba de combustible')
```

--------------------------------------------------------------------------------

### Ejercicio 13.

Realizar las inserciones provistas en el archivo inserciones.sql. Validar mediante una consulta que la tabla REPARACIONESPORCLIENTE se esté actualizando correctamente.

``

--------------------------------------------------------------------------------

### Ejercicio 14.

Considerando la siguiente consulta

```sql
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

``

--------------------------------------------------------------------------------

### Ejercicio 15.

Análisis de permisos.

a) Para cada punto de la práctica incluido en el cuadro, ejecutarlo con cada uno de los usuarios creados en el punto 1 e indicar con cuáles fue posible realizar la operación.

b) Determine para cada caso, cuál es el conjunto de permisos mínimo.

c) Desde su punto de vista y contemplando lo visto en la materia, explique cuál es la manera óptima de asignar permisos a los usuarios.

``
