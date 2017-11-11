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
        while (!empty(colasMedico[m])) wait(medicos)
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
