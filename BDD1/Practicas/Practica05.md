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
