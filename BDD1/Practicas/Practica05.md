# Ejercicio 6

Dado el siguiente esquema:

```
PELICULA (id, titulo, id_clasificacion)
GENERO (id, nombre)
PELICULA_GENERO (id_pelicula, id_genero)
CLASIFICACION (id, descripcion)
```

Hallar los géneros que sólo tienen películas de clasificación descripta como "+16". Indicar el nombre de los géneros. Considerar que puede haber tanto géneros como clasificaciones sin películas.

```
!+16 <= P (id_clasificacion) (pi (id) (o (descripcion != +16) CLASIFICACION))
P!+16 <= P (id_pelicula) (pi (id) PELICULA |X| !+16)
G!+16 <= P (id) (pi (id_genero) (PELICULA_GENERO |X| P!+16))
G+16 <= GENERO - (GENERO |X| G!+16)

El resultado contiene los generos que no tienen ninguna pelicula, en caso que exista alguno.
```

--------------------------------------------------------------------------------

# Ejercicio 9

InscripcionesINSCRIPCIONES (#inscripcion, fechaInscripcion, #alumno, #comision, horario, #aula, nombreAula, capacidad, nombreAlumno, dniAlumno, #ayudante)

Donde

- Dentro de una cátedra, se quieren administrar las inscripciones de los alumnos a las diferentes comisiones.
- Una comisión tiene un aula y un horario asignado. Las aulas pueden compartirse, es decir que en un aula puede haber dos o más comisiones en el mismo horario.
- Cada aula tiene un nombre y una capacidad. El nombre puede repetirse para diferentes aulas.
- El #aula y #comisión son únicos en el sistema.
- Cada comisión lleva su propia cuenta de #inscripcion, es decir, los #inscripcion no son únicos en el sistema y pueden repetirse en diferentes comisiones.
- Una inscripción en una comisión se hace en una ón se hace en una fech
- En una misma fecha, un alumno puede inscibirse a diferentes comisiones.
- Un alumno tiene un #alumno, que es único. Además, tiene un nombre y un dni (que también es único).
- Cada comisión tiene asignados a varios ayudantes. El #ayudante es único en el sistema. Un ayudante puede estar asignado a más de una comisión.

```
Dependencias Funcionales:
    df1: #comision                  --> #aula, horario
    df2: #aula                      --> nombreAula, capacidad
    df3: #comision, #inscripcion    --> fechaInscripcion, #alumno
    df4: #comision, #inscripcion    --> fechaInscripcion, dniAlumno
    df5: #alumno                    --> nombreAlumno, dniAlumno
    df6: dniAlumno                  --> #alumno, nombreAlumno

cc1: {#comision, #inscripcion, #ayudante}

I1(#comision, #aula, horario)
I2(#inscripcion, fechaInscripcion, #alumno, #comision, nombreAula, capacidad, nombreAlumno, dniAlumno, #ayudante)

Se pierde df2
Aplicando algoritmo:
    Partiendo desde #aula, quiero llegar a incorporar nombreAula y capacidad.

    Forma facil es:
        Para probar que se perdio la dependencia funcional debemos utilizar el algoritmo.

        Partiendo de res = #aula
        Por cada particion se incluyen en res los miembros de res+ que se encuentren en la particion.

        (#aula)+ =
            Usando df2: {#aula, nombreAula, capcidad}
            Ninguna otra df tiene a #aula, nombreAula o capacidad como determinantes

        Encontramos a #aula solo en I1, pero ningun otro atributo de la tabla forma parte de (#aula)+.
        Por lo tanto se perdio la dependencia funcional 2

    Forma completa:
        Res = #aula
        i = 1
            Res = #aula U ((#aula n (#comision, #aula, horario))+ n #comision, #aula, horario)
            Res = #aula U ((#aula)+ n #comision, #aula, horario)
            Res = #aula U ((#aula, nombreAula, capacidad) n #comision, #aula, horario))
            Res = #aula U (#aula)
            Res no cambia
        i = 2
            Res = #aula U ((#aula n (#inscripcion, fechaInscripcion, #alumno, #comision, nombreAula, capacidad, nombreAlumno, dniAlumno, #ayudante))+ n (#inscripcion, fechaInscripcion, #alumno, #comision, nombreAula, capacidad, nombreAlumno, dniAlumno, #ayudante))

            Res = #aula U (vacio+ n (#inscripcion, fechaInscripcion, #alumno, #comision, nombreAula, capacidad, nombreAlumno, dniAlumno, #ayudante))

            Res = #aula U (vacio n (#inscripcion, fechaInscripcion, #alumno, #comision, nombreAula, capacidad, nombreAlumno, dniAlumno, #ayudante))

            Res = #aula U (vacio)
            Res no cambia

Paso a FN3
    I1(#comision, #aula, horario)
    I2(#aula, nombreAula, capacidad)
    I3(#comision, #inscripcion, fechaInscripcion, #alumno)
    I4(#comision, #inscripcion, fechaInscripcion, dniAlumno)
    I5(#alumno, nombreAlumno, dniAlumno)
    I6(dniAlumno, #alumno, nombreAlumno)

Ignoramos I4 y I6 porque son duplicados de I3 e I5 respectivamente
Agregamos I7(#comision, #inscripcion, #ayudante) porque la cc no esta incluida en ninguna tabla

Resultado final:
    Clave Primaria:
        {#comision, #inscripcion, #ayudante}
    Particiones en 3FN:
        I1(#comision, #aula, horario)
        I2(#aula, nombreAula, capacidad)
        I3(#comision, #inscripcion, fechaInscripcion, #alumno)
        I5(#alumno, nombreAlumno, dniAlumno)
        I7(#comision, #inscripcion, #ayudante)
```

--------------------------------------------------------------------------------

# Ejercicio 10

INSTALACIONES(idCuidador, nyAp, dni, idVivero, nombreVivero, mtrCuadradosVivero, tempPromedioVivero, idPlanta, nombrePlanta, idEspecie, nombreEspecie, quimicoPlanta, consultorVivero)

Donde:

- El idVivero es un identificador único que no se repite para diferentes viveros. Del vivero se conoce su nombre (diferentes viveros pueden tener el mismo nombre), los metros cuadrados que ocupa, la temperatura promedio que debe mantener y el cuidador responsable del mismo.
- Un mismo cuidador (idCuidador) puede cuidar diversos viveros. Tener en cuenta que un vivero tiene solamente un cuidador responsable asignado.
- Del cuidador se conoce su nombre y apellido y el dni. El idCuidador no se repite para diferentes cuidadores.
- El dni registrado en el esquema pertenece a un cuidador. El dni es un valor único que no se repite para diferentes cuidadores.
- El idPlanta es único. Por ejemplo, una planta es el helecho. De cada planta se conoce el nombre de la planta y la especie a la que pertenece
- El idEspecie es único. Un ejemplo de especie es el árbol. Cada planta pertenece a una única especie y a una especie pertenecen diversas plantas.
- A cada planta en un vivero (por ejemplo: helecho en el vivero 1) se le aplica un conjunto de químicos. Los mismos químicos se pueden aplicar a plantas de diferentes viveros y a diferentes plantas en el mismo vivero.
- Cada vivero tiene diversos consultores de viveros (consultorVivero), que son quienes asesoran ante dudas eventuales. El mismo consultor puede asesorar en diversos viveros

```
Dependencias funcionales:
    df1: idVivero   --> nombreVivero, mtrCuadradosVivero, tempPromedioVivero, idCuidador
    df2: idCuidador --> nyAp, dni
    df3: dni        --> nyAp, idCuidador
    df4: idPlanta   --> nombrePlanta, idEspecie
    df5: idEspecie  --> nombreEspecie

cc: {idVivero, idPlanta, quimicoPlanta, consultorVivero}

I1(idCuidador, nyAp, dni)
I2(idVivero, nombreVivero, mtrCuadradosVivero, tempPromedioVivero, idCuidador)
I3(idEspecie, nombreEspecie)
I4(idPlanta, nombrePlanta, idEspecie)
I5(idVivero, idPlanta, quimicoPlanta, consultorVivero)

Dependencias Multivaluadas:
    dm1: idVivero   -->> consultorVivero
    dm2: consultorVivero    -->> idVivero
    dm3: idVivero, idPlanta -->> quimicoPlanta
    dm4: quimicoPlanta  -->> idVivero, idPlanta

I6(idVivero, consultorVivero)
I7(idVivero, idPlanta, quimicoPlanta)

Final:
    I1(idCuidador, nyAp, dni)
    I2(idVivero, nombreVivero, mtrCuadradosVivero, tempPromedioVivero, idCuidador)
    I3(idEspecie, nombreEspecie)
    I4(idPlanta, nombrePlanta, idEspecie)
    I6(idVivero, consultorVivero)
    I7(idVivero, idPlanta, quimicoPlanta)
```

--------------------------------------------------------------------------------

# Ejercicio 11

TransportesVIAJES(idTransporte, patenteT, idConductor,fechaViaje, idTipoMaterial, nombreM, gradoToxM, origen, destino, reglamentacionT, nombreC, domicilioC, modeloT, marcaT, toneladasT)

```
Dependencia Funcional:
    df1: idTransporte --> patenteT, modeloT, marcaT, toneladasT
    df2: patenteT   --> idTransporte, modeloT, marcaT, toneladasT
    df3: idConductor --> nombreC, domicilioC
    df4: idTipoMaterial --> nombreM, gradoToxM
    df5: idTransporte, fechaViaje --> idConductor, origen, destino
    df6: patenteT, fechaViaje   --> idConductor, origen, destino
    df7: idConductor, fechaViaje --> idTransporte, origen, destino
    df8: idConductor, fechaViaje --> patenteT, origen, destino

cc:
    (idConductor, fechaViaje, idTipoMaterial, reglamentacionT)
    (idTransporte, fechaViaje, idTipoMaterial, reglamentacionT)
    (patenteT, fechaViaje, idTipoMaterial, reglamentacionT)
```

```
X+
Res = X
for i = 1 to N do {
    si el determinante de dfi esta incluido en Res {
        Res = Res + determinados de dfi
    }
}

Se pierde df X -> A?
Res = X
for i = 1 to N do {
    Res = Res U ((Res n Ri)+ n Ri)
}

Perdi informacion?
    La interseccion de las dos particiones debe ser clave en alguna de las dos
Perdi dependencias funcionales?
    Todas tienen que valer en alguna de las dos particiones
Cumple con la definicion de BCNF?
    Todas los determinantes de las df que se cumplen en la particion deben ser superclave.
```
