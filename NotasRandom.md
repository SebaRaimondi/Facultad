```
Monitor Puente {
    cond cola
    int cant = 0

    function entrar() {
        cant++
        if (cant > 1) wait(cola)
    }
    function salir() {
        cant--
        signal(cola)
    }
}

Process Auto [id 1..N] {
    Puente.entrar()
    // Pasa por el puente
    Puente.salir()
}
```

```
Monitor BD {
    cond cola
    int libres = 5

    function usar() {
        while (libres == 0) wait(cola)
        libres--
    }
    function salir() {
        libres++
        signal(cola)
    }
}
```

```
Monitor Maquina {
    cond[100] esperando
    queue cola
    libre = true

    procedure solicitarAcceso(id) {
        if (!libre) {
            cola.insertarOrdenado(id)
            wait(esperando[id])
        }
        else {
            libre = false
        }
    }
    procedure liberar() {
        if (!empty(cola)) {
            signal(esperando[cola.pop()])
        }
        else {
            libre = true
        }
    }
}
```

```
Process Persona [p = 1..N] {
    Banco.llegoPersona(p)
    // Irse
}
Process Timer [t = 1..N] {
    Banco.llegoTimer(t)
    delay(15)
    Banco.terminoEspera(t)
}
Process Empleado [e = 2] {
    while (true) {
        Banco.atenderProximo(p)
        // Atender cliente
        Banco.termineDeAtender
    }
}
Monitor Banco {
    cond[N] persona
    cond[N] timer
    bool[N] llegoPersona
    string[N] estadoPersona
    queue cola
    cond empleados

    procedure llegoPersona(int p) {
        llegoPersona[p] = true
        estadoPersona[p] = 'Esperando'
        cola.encolar(p)
        signal(timer[t])
        signal(empleados)
        wait(persona[p])
    }   
    procedure llegoTimer(int t) {
        if (!llegoPersona[t]) wait(timer[t])
    }
    procedure terminoEspera(int t) {
        if (estadoPersona[t] == 'Esperando') {
            estadoPersona[t] == 'Se fué'
            cola.eliminar(t)
            signal(persona[t])
        }
    }
    procedure atenderProximo(int p) {
        while (empty(cola)) wait(empleados)
        p = cola.desencolar()
        estadoPersona[p] = 'Atendido'
    }
    procedure termineDeAtender(int p) {
        estadoPersona[p] = 'Se fue'
        signal(persona[p])
    }
}
```

```
Process Empleado [e = 1..50] {
    Empresa.llegoEmpleado(grupo)
    Grupo[grupo].llegoEmpleado()
}
Monitor Empresa {
    grupoActual = 1
    cantActual = 0
    cond empleados

    procedure llegoEmpleado(int grupo) {
        grupo = grupoActual
        cantActual++
        if (cantActual == 5) grupoActual++
    }
}
Monitor Grupo [g = 1..10] {
    cond empleados
    int esperando = 0

    procedure llegoEmpleado() {
        esperando++
        if (esperando < 5) wait(empleados)
        else {
            delay()         // Tiempo que tarden en revisar el pozo
            signalAll(empleados)
        }
    }
}
```

```
Process Jugador [j = 1..20] {
    int cancha, equipo

    equipo = DarEquipo()
    Equipo[equipo].llegoJugador(cancha)
    Cancha[cancha].llegoJugador()
}
Monitor Equipo [e = 1..4] {
    int jugadores = 0
    int canchaEquipo
    cond esperando

    procedure llegoJugador(var int cancha) {
        jugadores++
        if (jugadores == 5) {
            Coordinador.pedirCancha(canchaEquipo)
            signalAll(esperando)
        }
        else wait(esperando)
        cancha = canchaEquipo
    }
}
Monitor Cancha [c = 1..2] {
    int jugadores = 0
    cond esperando

    procedure llegoJugador() {
        jugadores++
        if (jugadores < 10) wait(esperando)
        else {
            delay(50)               // Juegan
            signalAll(esperando)
        }
    }
}
Monitor Coordinador {
    int pedidos = 0

    process pedirCancha(var int cancha) {
        pedidos++
        if (pedidos < 11) cancha = 1
        else cancha = 2
    }
}
```

```
Process Alumno [a = 1..50] {
    int grupo,
    Escuela.llegoAlumno(grupo, a)
    delay()                         // Realiza la practica
    Coordinador.terminoAlumno(grupo)
    Coordinador.buscarNota(nota, grupo)
}
Process JTP {
    int[50] grupos
    Escuela.llegoJTP()
    for i = 1 to 50 do grupos[i] = DarNumero()
    Escuela.asignarGrupos(grupos)
}
Monitor Coordinador {
    int cantAlumnos = 0
    cond alumnos
    cond jtp
    int[50] grupos
    bool gruposDisponibles = false

    int terminadosPorGrupo[25] = 0
    cond[50] grupo[25]
    int[50] notas

    process llegoAlumno(var int grupo, int id) {
        cantAlumnos++
        if (cantAlumnos == 50) signal(jtp)
        if (!gruposDispobibles) wait(alumnos)
        grupo = grupos[id]
    }
    process llegoJTP() {
        if (cantAlumnos < 50) wait(jtp)
    }
    process asignarGrupos(int[50] g) {
        grupos = g
        gruposDisponibles = true
        signalAll(alumnos)
    }
    process terminoAlumno(grupo) {
        terminadosPorGrupo[grupo]++
        if (terminadosPorGrupo == 2) {
            colaGrupos.encolar(grupo)
        }
    }
    process buscarNota(var int nota, int grupo) {
        if (!notaLista[grupo]) wait(grupo[grupo])
        nota = notas[grupo]
    }
    blablabla
}
```

--------------------------------------------------------------------------------

# Punto 8

Suponga que en una fábrica de camisas trabajan 40 operarios que deben realizarse 5000 camisas. Para realizar una camisa se requieren 8 materiales diferentes, por lo que existe un depósito para cada uno de estos donde se almacenan.

Cuando todos los operarios han llegado el encargado los agrupa de a cuatro (les asigna un número de grupo de 1 a 10). Los 4 operarios de grupo deben juntarse y luego comenzar a fabricar las camisas.

Para realizar cada camisa, entre los empleados del grupo deben buscar los 8 materiales necesarios, cuando lo han conseguido, los 4 la fabrican conjuntamente.

Luego de que todas las camisas han sido fabricadas los operarios deben retirarse.

Nota: no se deben fabricar camisas de más. No se puede suponer nada sobre los tiempos, es decir, el tiempo en que un operario tarda en buscar los elementos, ni el tiempo en que tarda un grupo en fabricar una camisa.

```
Process Operario [o = 1..40] {
    int grupo
    int material
    bool buscarMateriales

    Fabrica.lleguoOperario(o, grupo)

    Grupo[grupo].fabricar?(seguirFabricando)
    while (seguirFabricando) {

        Grupo[grupo].materiales?(buscarMateriales, material)
        while (buscarMateriales) {
            Deposito[material].buscarMaterial()
            Grupo[grupo].depositarMaterial()
            Grupo[grupo].materiales?(buscarMateriales, material)
        }

        Grupo[grupo].fabricar()
        Grupo[grupo].fabricar?(seguirFabricando)
    }
}
Monitor Fabrica {
    int grupoActual = 1
    int cantLlegaron = 0
    int camisas = 0

    procedure llegoOperario(int o, var int grupo) {
        grupo = grupoActual
        cantLlegaron++
        if (cantLlegaron == 4) {
            grupoActual++
            cantLlegaron = 0
        }
    }
    procedure fabricar?(var bool fabricar) {
        if (camisas == 5000) fabricar = false
        else {
            camisas++
            fabricar = true
        }
    }
}
Monitor Grupo [g = 1..10] {
    bool fabricar
    bool chequeado = false
    int[8] materiales = 0
    cond operarios
    int esperando = 0

    procedure fabricar?(var bool seguirFabricando) {
        if (!chequeado) {
            Fabrica.fabricar?(fabricar)
            chequeado = true
        }
        seguirFabricando = fabricar
    }
    procedure materiales?(var bool buscarMateriales, var int material) {
        material = 0
        buscarMateriales = false
        for i = 1 to 8 if (materiales[i] == 0) material = i
        if (material != 0) {
            materiales[material]++
            buscarMateriales = true
        }
    }
    procedure depositarMaterial() {
        delay()                     // Lo que tarde en depositar el material ?
    }
    procedure fabricar() {
        esperando++
        if (esperando == 4) {
            delay()                 // Fabrican la camisa
            chequeado = false
            signalAll(operarios)
        }
        else wait(operarios)
        esperando--
    }
}
Monitor Deposito [d = 1..8] {
    procedure buscarMaterial() {
        delay()                     // Lo que tarde en tomar el material
    }
}
```
