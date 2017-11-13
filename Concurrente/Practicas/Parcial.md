# Punto1

En un banco se tiene un sistema que administra el uso de una sala de reuniones por parte de N clientes. Los clientes se clasifican en Habituales y Temporales. La sala puede ser usada por un unico cliente a la vez y cuando esta libre se debe determinar a quien permitirle su uso dando prioridad a los clientes Habituales. Dentro de cada clase de cliente se debe respetar el orden de llegada. Nota: suponga que existe una funcion Tipo() que le indica al cliente de que tipo es.

```
Process Cliente [c = 1..N] {
    tipo = Tipo()
    if (tipo == 'Habitual') Recepcion!esperaHabitual(c)
    else Recepcion!esperaTemporal(c)
    Sala!esperarTurno()
    delay()                 // Utilisa la sala
    Sala!liberarSala(c)
}
Process Sala {
    int c
    while (true) {
        Recepcion!libre()
        Recepcion?proximo(c)
        Cliente[c]?esperarTurno()
        Sala?liberarSala()
    }
}
Process Recepcion {
    queue habituales
    queue temporales
    int c
    while (true) {
        if  Cliente[*]?esperaHabitual(c) --> habituales.encolar(c)

            Cliente[*]?esperaTemporal(c) --> temporales.encolar(c)

            (!empty(habituales) || !empty(temporales)); Sala?libre() --> {
                if (!empty(habituales)) c = habituales.desencolar()
                else c = temporales.desencolar()
                Sala!proximo(c)
            }
    }
}
```

--------------------------------------------------------------------------------

# Punto2

En un centro de oftalmologia hay 2 medicos con diferentes especialidades. Existen N pacientes que deben ser atendidos, para esto algunos de los pacientes pueden ser atendidos indistintamente por cualquiera de los medicos, y otros solo por uno de los medicos en particular. Cada paciente saca turno con cada uno de los medicos que lo pueden atender, y espera hasta que le llegue el turno con uno de ellos, espera a que terminde a atenderlo y se retira.

Nota: suponga que existe una funcion ElegirMedico() que retorna 1, 2 o 3 (1 idica que solo debe sacar turno con el medico 1; 2 indica que solo debe sacar turno con el medico 2; 3 indica que debe sacar turno cn ambas medico. Maximizar la concurrencia.)

```
Process Paciente [p = 1..N] {
    int m = ElegirMedico()
    Oftalmoloia.pedirTurno(m, p)
}
Process Medico [m = 1..2] {
    int p
    while (true) {
        Oftalmoloia.atender(m, p)
        // Atiende al paciente.
        Oftalmologia.termino(p)
    }
}
Monitor Oftalmologia {
    queue[2] colasMedico
    int[2] cantCola = 0
    int[N] dobles = false
    cond[N] paciente
    cond[2] medicos

    procedure pedirTurno(int m, int p) {
        if (m = 1 || m = 3) {
            colasMedico[1].encolar(p)
            cantCola[1]++
            signal(medico[1])
        }
        if (m = 2 || m = 3) {
            colasMedico[2].encolar(p)
            cantCola[2]++
            signal(medico[2])
        }
        if (m = 3) dobles[p] = true
        wait(paciente[p])
    }

    procedure atender(int m, var int p) {
        while (!empty(colasMedico[m])) wait(medicos[m])
        p = colasMedico[m].desencolar()

        if (m = 1) opuesto = 2
        else opuesto = 1

        if (dobles[p]) colasMedico[opuesto].eliminar(p)
    }
    procedure termino(int p) {
        signal(paciente[p])
    }
}
```

--------------------------------------------------------------------------------

## Otro parcial

### Ej1

**Semaforos o monitores**:

En un centro de genetica se debe administrar el uso de 2 maquinas secuanciadoras de ADN con diferentes caracteristicas, donde cada maquina se puede usar por un unico investigador a la vez.

Existen N investigadores que deben secuenciar una muestra de ADN cada uno, para esto algunos investigaodres pueden usar indistintamente cualquiera de las maquinas, y otros pueden usar una de ellas en particular. Cada investigador saca turno en cada una de las maquinas que le pueden servir, y espera hasta que le llegue el turno en una de ellas, la usa y se retira.

Nota: suponga que existe una funcion ElegirMaquina() que retoran 1, 2 o 3 (1 solo en maquina 1, 2 solo en maquina 2, 3 en ambas.)

**Semaforos**:

```
string[N] estado
sem[N] sEstado = 1

queue[2] cola
sem[2] sCola = 1

sem[N] investigadores = 1
sem[2] maquinas = 1

Process Maquina [m = 1..2] {
    while (true) {
        P(maquinas[m])
        P(sCola[m])
        inv = cola[m].desencolar()
        V(sCola[m])
        P(sEstado[inv])
        if (estado[inv] == 'Esperando') {
            estado[inv] = 'Atendido'
            V(sEstado[inv])
            delay()                     // El investigador usa la maquina
            V(investigadores[inv])
        }
        else V(sEstado[inv])
    }
}
Process Investigador [i = 1..N] {
    int maquina = ElegirMaquina()
    P(sEstado[i])
    estado[i] = 'Esperando'
    V(sEstado[i])
    if (maquina == 3) {
        P(sCola[1])
        cola[1].encolar(i)
        V(sCola[1])
        V(maquinas[1])
        P(sCola[2])
        cola[2].encolar(i)
        V(sCola[2])
        V(maquinas[2])
    }
    else {
        P(sCola[maquina])
        cola[maquina].encolar(i)
        V(sCola[maquina])
        V(maquinas[maquina])
    }
    P(investigadores[i])        // Espera hasta usar la maquina
    // Se va
}
```

**Monitores**:

```
Process Investigador [i = 1..N] {
    int maquina = ElegirMaquina()
    Estado[i].esperar(maquina)
}
Monitor Estado [e = 1..N] {
    string estado
    cond esperando
    procedure esperar(int maquina) {
        if (maquina == 3)  {
            Cola[1].esperar(e, true)
            Cola[2].esperar(e, true)
        }
        else Cola[maquina].esperar(e, false)
        wait(esperando)
    }
    procedure atendido() {
        signal(esperando)
    }
}
Process Maquina [m = 1..2] {
    int inv
    bool esDoble
    while (true) {
        Cola[m].pedirSiguiente(inv)
        delay()                     // La usa el investigador inv
        Estado[inv].termino(inv)
    }
}
Monitor Cola [c = 1..2] {
    queue cola
    bool[N] dobles = false
    bool atendido = true
    procedure esperar(int e, bool esDoble) {
        if (esDoble) dobles[e] = true
        cola.encolar(e)
    }
    procedure pedirSiguiente(var int inv) {
        atendido = true
        while (atendido) {
            inv = cola.desencolar()
            if (esDoble[inv]) Dobles.fueAtendido(inv, atendido)
            else atendido = false
        }
    }
    procedure termino(int inv) {
        Estado[inv].atendido()
    }
}
Monitor Dobles {
    bool atendido[N] = false

    procedure fueAtendido(int inv, var bool fueAtendido) {
        fueAtendido = atendido[inv]
        atendido[inv] = true
    }
}
```

## Ej2

**PMS o ADA**:

Se tiene un sistema que administra el uso de una Supercomputadora por parte de N personas. Las personas tienen diferentes categorias (A, B, C). La supercomputadora puede ser usada por una unica persona a la vez. Cuando esta libre se debe determinar a quien permitirle su uso de acuerdo a la prioridad determinada por la categoria: la categoria A es de mayor prioridad, luego la B y por ultimo la C. Dentro de cada categoria se debe respetar el orden de llegada.

Nota: suponga que existe una funcion Categoria() que le indica a la persona de que tipo es.

**PMS**:

```
Process Persona [p = 1..N] {
    char categoria = Categoria()
    int num

    if (categoria = 'A') num = 1
    elseif (categoria = 'B') num = 2
    elseif (categoria = 'C') num = 3

    Cola!encolar(p, num)
    Super?termino()
    // Se va
}
Process Super {
    int p
    while (true) {
        Cola!disponible()
        Cola?proximo(p)
        delay()                 // La persona usa la supercomputadora
        Persona[p].termino()
    }
}
Process Cola {
    queue[3] cola
    int p, num

    while (true) {                  // Con if se puede seguro, do sirve? si sirve es mejor.
        do  Persona[*]?encolar(p, num) -->
                cola[num].encolar(p)

            (!empty(cola[1])); Super?disponible() -->
                Super!proximo(cola[1].desencolar())

            (empty(cola[1]) && !empty(cola[2])); Super?disponible() -->
                Super!proximo(cola[2].desencolar())

            (empty(cola[1]) && empty(cola[2]) && !empty(cola[3])); Super?disponible() -->
                Super!proximo(cola[3].desencolar())
        od
    }
}
```

**ADA**:

![Thinking emoji](https://emojipedia-us.s3.amazonaws.com/thumbs/160/google/110/thinking-face_1f914.png)
