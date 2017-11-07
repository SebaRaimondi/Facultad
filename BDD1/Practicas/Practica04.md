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
INNER JOIN sucursal ON cliente.ciudadCliente = sucursal.ciudadSucursal

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

```

7) Para aquellas reparaciones que tengan registrados mas de 3 repuestos, listar el DNI del cliente, el código de sucursal, la fecha de reparación y la cantidad de repuestos utilizados. Realice la consulta en ambas bases.

```
```
