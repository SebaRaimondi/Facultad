# Práctica 4 – Pasaje de Mensajes

## CONSIDERACIONES PARA RESOLVER LOS EJERCICIOS DE PMA:

- Los canales son compartidos por todos los procesos.
- Cada canal es una cola de mensajes, por lo tanto el primer mensaje encolado es el primero en ser atendido.
- Por ser pasaje de mensajes asincrónico el send no bloquea al emisor.
- Se puede usar la sentencia empty para saber si hay algún mensaje en el canal, pero no se puede consultar por la cantidad de mensajes encolados.
- Se puede utilizar el if/do no determinístico donde cada opción es una condición boolena donde se puede preguntar por variables locales y/o por empty de canales.

  ```
    if (cond 1) → Acciones 1;
     (cond 2) → Acciones 2;
    ...
     (cond N) → Acciones N;
    end if
  ```

  De todas las opciones cuya condición sea Verdadera elige una en forma no determinística y ejecuta las acciones correspondientes. Si ninguna es verdadera sale del if/do si hacer nada.

- Se debe tratar de evitar hacer busy waiting (sólo hacerlo si no hay otra opción).

- En todos los ejercicios el tiempo debe representarse con la función delay.

--------------------------------------------------------------------------------

### Ejercicio 1.

Supongamos que tenemos una abuela que tiene dos tipos de lápices para dibujar: 10 de colores y 15 negros. Además tenemos tres clases de niños que quieren dibujar con los lápices: los que quieren usar sólo los lápices de colores (tipo C), los que usan sólo los lápices negros (tipo N), y los niños que usan cualquier tipo de lápiz (tipo A).

a) Implemente un código para cada clase de niño de manera que ejecute pedido de lápiz, lo use por 10 minutos y luego lo devuelva y además el proceso abuela encargada de asignar los lápices.

```
chan pedidoColor
chan pedidoNegro
chan pedidoCualquiera
chan devolverColor
chan devolverNegro
chan canalLapiz[1..N]

Process Abuela {
    color = 10
    negro = 15

    while (true) {
        if (!empty(pedidoColor) && color > 0) {
            recive pedidoColor(id)
            send canalLapiz[id]("color")
            color--
        }
        if (!empty(pedidoNegro) && negro > 0) {
            recive pedidoNegro(id)
            send canalLapiz[id]("negro")
            negro--
        }
        if (!empty(pedidoCualquiera) && color > 0) {
            recive pedidoCualquiera(id)
            send canalLapiz[id]("color")
            color--
        }
        if (!empty(pedidoCualquiera) && negro > 0) {
            recive pedidoCualquiera(id)
            send canalLapiz[id]("negro")
            negro--
        }
        if (!empty(devolverColor)) {
            recive devolverColor()
            color++
        }
        if (!empty(devolverNegro)) {
            recive devolverNegro()
            negro++
        }
    }
}

Process ChicoC [c = 1 to C] {
    string lapiz
    while (true) {
        send pedidoColor(c)
        receive canalLapiz[i](lapiz)
        delay(10)
        send devolverColor()
    }
}

Process ChicoN [n = C+1 to N+C] {
    string lapiz
    while (true) {
        send pedidoNegro(n)
        receive canalLapiz[i](lapiz)
        delay(10)
        send devolverNegro()
    }
}

Process ChicoA [a = N+C+1 to A+N+C] {
    string lapiz
    while (true) {
        send pedidoCualquiera(a)
        receive canalLapiz[i](lapiz)
        delay(10)
        if (lapiz == "color") send devolverColor()
        else send devolverNegro()
    }
}
```

b) Modificar el ejercicio para que a los niños de tipo A se les puede asignar un lápiz sólo cuando: hay lápiz negro disponible y ningún pedido pendiente de tipo N, o si hay lápiz de color disponible y ningún pedido pendiente de tipo C.

```
Process Abuela {
    ...

    while (true) {
        ...

        if (!empty(pedidoCualquiera) && color > 0 && empty(pedidoColor)) {
            recive pedidoCualquiera(id)
            send canalLapiz[id]("color")
            color--
        }
        if (!empty(pedidoCualquiera) && negro > 0 && empty(pedidoNegro)) {
            recive pedidoCualquiera(id)
            send canalLapiz[id]("negro")
            negro--
        }

        ...
    }
}

...
```

Nota: se deben modelar los procesos niño y el proceso abuela.

--------------------------------------------------------------------------------

### Ejercicio 2.

Se desea modelar el funcionamiento de un banco en el cual existen 5 cajas para realizar pagos. Existen P personas que desean pagar. Para esto cada una selecciona la caja donde hay menos personas esperando, una vez seleccionada espera a ser atendido.

Nota: maximizando la concurrencia, deben usarse los valores actualizados del tamaño de las colas para seleccionar la caja con menos gente esperando.

```
chan buscarCola(int)
chan menorCola[1..N](int)
chan esperarCaja[1..N](int)
chan atiende[1..P]()
chan termino(int)

Process Banco {
    while (true) {
        if (!empty(buscarCola) && empty(termino)) {
            receive buscarCola(id)
            send menorCola[id](cola.min)
            cola[cola.min]++
        }
        if (!empty(termino)) {
            receive termino(caja)
            cola[caja]--
        }
    }
}

Process Caja [c = 1 to 5] {
    while (true) {
        receive esperarCaja[c](id)
        delay(LoQueTardeEnAtenderlo)
        send atiende[id]()
    }
}

Process Persona [p = 1 to N] {
    send buscarCola(p)
    receive menorCola[p](caja)
    send esperarCaja[caja](p)
    receive atiende[p]()
    send termino(caja)
}
```

--------------------------------------------------------------------------------

### Ejercicio 3.

Se debe modelar una casa de Comida Rápida, en el cual trabajan 2 cocineros y 3 vendedores. Además hay C clientes que dejan un pedido y quedan esperando a que se lo alcancen.

Los pedidos que hacen los clientes son tomados por cualquiera de los vendedores y se lo pasan a los cocineros para que realicen el plato. Cuando no hay pedidos para atender, los vendedores aprovechan para reponer un pack de bebidas de la heladera (tardan entre 1 y 3 minutos para hacer esto).

Repetidamente cada cocinero toma un pedido pendiente dejado por los vendedores, lo cocina y se lo entrega directamente al cliente correspondiente.

Nota: maximizar la concurrencia.

```
Process Cocinero [c = 1..2] {
    while (true) {
        receive hacerPedido(c, pedido)
        plato = preparar(pedido)
        send plato[c]()
    }
}

Process Vendedores [v = 1..3] {
    while (true) {
        while (empty(pedido)) {
            delay(random(1..3))     // Reponer bebidas
        }
        if (!empty(pedido)) {
            receive pedido(c, pedido)
            send hacerPedido(c, pedido)
        }
    }
}

Process Cliente [c = 1..C] {
    string pedido = generar()
    send pedido(c, pedido)
    receive plato[c]()
}
```

--------------------------------------------------------------------------------

### Ejercicio 4.

Se desea modelar una competencia de atletismo. Para eso existen dos tipos de procesos: C corredores y un portero. Los corredores deben esperar que se habilite la entrada a la pista, donde deben esperar que lleguen todos los corredores para comenzar. El portero es el encargado de habilitar la entrada a la pista.

a) Implementar usando un coordinador.

```
chan llegoCorredor()
chan comenzar()

Process Corredor [c = 1..N] {
    send llegoCorredor()
    receive comenzar()
}

Process Portero {
    receive llegaronTodos()
    for i = 1 to N do send comenzar()
}

Process Coordinador {
    for i = 1 to C do receive llegoCorredor()
    send llegaronTodos()
}
```

b) Implementar sin usar un coordinador.

```
chan llegoCorredor()
chan comenzar()

Process Corredor [c = 1..N] {
    send llegoCorredor()
    receive comenzar()
}

Process Portero {
    for i = 1 to N do receive llegoCorredor()
    for i = 1 to N do send comenzar()
}
```

NOTAS: el proceso portero NO puede contabilizar nada, su única función es habilitar la entrada a la pista; NO se puede suponer ningún orden en la llegada de los corredores al punto de partida.

--------------------------------------------------------------------------------

### Ejercicio 5.

Suponga que N personas llegan a la cola de un banco. Una vez que la persona se agrega en la cola no espera más de 15 minutos para su atención, si pasado ese tiempo no fue atendida se retira. Para atender a las personas existen 2 empleados que van atendiendo de a una y por orden de llegada a las personas.

```
lostimersmedanmiedo
```

--------------------------------------------------------------------------------

### Ejercicio 6.

Existe una casa de comida rápida que es atendida por 1 empleado. Cuando una persona llega se pone en la cola y espera a lo sumo 10 minutos a que el empleado lo atienda. Pasado ese tiempo se retira sin realizar la compra.

a) Implementar una solución utilizando un proceso intermedio entre cada persona y el empleado.

```
lostimersmedanmiedo
```

b) Implementar una solución sin utilizar un proceso intermedio entre cada persona y el empleado.

```
lostimersmedanmiedo
```

--------------------------------------------------------------------------------

#### CONSIDERACIONES PARA RESOLVER LOS EJERCICIOS DE PMS:

- Los canales son punto a punto y no deben declararse.
- No se puede usar la sentencia empty para saber si hay algún mensaje en un canal.
- Tanto el envío como la recepción de mensajes es bloqueante.
- Sintaxis de las sentencias de envío y recepción:

  Envío: nombreProcesoReceptor!port (datos a enviar)

  Recepción: nombreProcesoEmisor?port (datos a recibir)

  El port (o etiqueta) puede no ir. Se utiliza para diferenciar los tipos de mensajes que se podrían comunicarse entre dos procesos.

- En la sentencia de comunicación de recepción se puede usar el comodín * si el origen es un proceso dentro de un arreglo de procesos. Ejemplo:

  `Clientes[*]?port(datos)`.

- Sintaxis de la Comunicación guardada:

  ```
    Guarda: (condición booleana); sentencia de recepción → sentencia a realizar
  ```

  Si no se especifica la condición booleana se considera verdadera (la condición booleana sólo puede hacer referencia a variables locales al proceso).

  Cada guarda tiene tres posibles estados:

  ```
    Elegible: la condición booleana es verdadera y la sentencia de comunicación se puede resolver inmediatamente.

    No elegible: la condición booleana es falsa.

    Bloqueada: la condición booleana es verdadera y la sentencia de comunicación no se puede resolver inmediatamente.
  ```

  Sólo se puede usar dentro de un if o un do guardado:

  ```
    El IF funciona de la siguiente manera: de todas las guardas elegibles se selecciona una en forma no determinística, se realiza la sentencia de comunicación correspondiente, y luego las acciones asociadas a esa guarda.

    Si todas las guardas tienen el estado de no elegibles, se sale sin hacer nada.

    Si no hay ninguna guarda elegible, pero algunas están en estado bloqueado, se queda esperando en el if hasta que alguna se vuelva elegible.

    El DO funciona de la siguiente manera: sigue iterando de la misma manera que el if hasta que todas las guardas hasta que todas las guardas sean no elegibles.
  ```

--------------------------------------------------------------------------------

### Ejercicio 7.

En una estación de comunicaciones se cuenta con 10 radares y una unidad de procesamiento que se encarga de procesar la información enviada por los radares. Cada radar repetidamente detecta señales de radio durante 15 segundos y le envía esos datos a la unidad de procesamiento para que los analice. Los radares no deben esperar a ser atendidos para continuar trabajando.

Nota: maximizar la concurrencia.

```
Process Radar [r = 1 .. 10] {
    while true {
        delay(15)           // Segundos
        Buffer!SeñalDeRadio(datos)
    }
}

Process Procesador {
    while true {
        Buffer!PuedeProcesar()
        Buffer!Señal(datos)
        delay()         // Lo que tarde en procesar los datos.
    }

}

Process Buffer {
    cola cola
    while true {
        do {
            Radar?SeñalDeRadio[*](datos)   --> cola.encolar(datos)
            (!empty(cola) && Procesador?PuedeProcesar())    --> Procesador!Señal(cola.desencolar())
        }
    }
}
```

--------------------------------------------------------------------------------

### Ejercicio 8.

Supongamos que tenemos una abuela que tiene dos tipos de lápices para dibujar: 10 de colores y 15 negros. Además tenemos tres clases de niños que quieren dibujar con los lápices: los que quieren usar sólo los lápices de colores (tipo C), los que usan sólo los lápices negros (tipo N), y los niños que usan cualquier tipo de lápiz (tipo A).

a) Implemente un código para cada clase de niño de manera que ejecute pedido de lápiz, lo use por 10 minutos y luego lo devuelva y además el proceso abuela encargada de asignar los lápices.

```
Process Abuela {
    color = 10
    negro = 15

    while (true) {
        do {
            ChicoC?PedidoColor[*](id) && color > 0      -->
                ChicoC!DarColor[id]()
                color--
            ChicoC?DevuelveColor[*]()                   -->
                color++

            ChicoN?PedidoNegro[*](id) && negro > 0      -->
                ChicoN!DarNegro[id]()
                negro--
            ChicoN?DevuelveNegro[*]()                   -->
                negro++

            ChicoA?PedidoCualquiera[*](id) && color > 0 -->
                ChicoC!DarCualquiera[id]("color")
                color--
            ChicoA?PedidoCualquiera[*](id) && negro > 0 -->
                ChicoC!DarCualquiera[id]("negro")
                negro--
            ChicoA?DevuelveCualquiera[*](lapiz)         -->
                if (lapiz == "color") color++
                else negro++
        }
    }
}

Process ChicoC [c = 1 to C] {
    while (true) {
        Abuela!PedidoColor(c)
        Abuela?DarColor()
        delay(10)
        Abuela!DevuelveColor()
    }
}

Process ChicoN [n = C+1 to N+C] {
    while (true) {
        Abuela!PedidoNegro(n)
        Abuela!DarNegro()
        delay(10)
        Abuela!DevuelveNegro()
    }
}

Process ChicoA [a = N+C+1 to A+N+C] {
    while (true) {
        Abuela!PedidoCualquiera(a)
        Abuela?DarCualquiera(lapiz)
        delay(10)
        Abuela!DevolverCualquiera(lapiz)
    }
}
```

b) Modificar el ejercicio para que a los niños de tipo A se les puede asignar un lápiz sólo cuando: hay lápiz negro disponible y ningún pedido pendiente de tipo N, o si hay lápiz de color disponible y ningún pedido pendiente de tipo C.

```
Si lo de borre no esta bien rip
```

Nota: se deben modelar los procesos niño y el proceso abuela.

--------------------------------------------------------------------------------

### Ejercicio 9.

Se debe modelar la atención en una panadería por parte de 3 empleados. Hay C clientes que ingresan al negocio para ser atendidos por cualquiera de los empleados, los cuales deben atenderse de acuerdo al orden de llegada.

Nota: maximizar la concurrencia.

```
Process Cliente [c = 1..N] {
    Panaderia!DarPedido(c)
    Empleado[*]?Atender()
}

Process Empleado [e = 1..3] {
    while true {
        Panaderia!Libre(e)
        Panaderia?PuedeAtenderA(c)
        Cliente[c]!Atender()
    }
}

Process Panaderia {
    cola clientes

    while true {
        if {
            Cliente[*]?DarPedido(c)            --> clientes.encolar(c)
            !empty(clientes) && Empleado[*]?Libre(e)   --> Empleado!PuedeAtenderA(clientes.desencolar())
        }
    }
}
```

--------------------------------------------------------------------------------

### Ejercicio 10.

Existe una casa de comida rápida que es atendida por 1 empleado. Cuando una persona llega se pone en la cola y espera a lo sumo 10 minutos a que el empleado lo atienda.

Pasado ese tiempo se retira sin realizar la compra.

a) Implementar una solución utilizando un proceso intermedio entre cada persona y el empleado.

b) Implementar una solución sin utilizar un proceso intermedio entre cada persona y el empleado.
