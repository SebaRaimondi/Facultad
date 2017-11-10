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

    procedure llegoPersona(int p) {
        llegoPersona[p] = true
        estadoPersona[p] = 'Esperando'
        cola.encolar(p)
        signal(timer[t])
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
        p = cola.desencolar()
        estadoPersona[p] = 'Atendido'
    }
    procedure termineDeAtender(int p) {
        estadoPersona[p] = 'Se fue'
        signal(persona[p])
    }
}
```
