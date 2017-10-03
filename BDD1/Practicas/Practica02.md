1) Dados los siguientes esquemas
DUEÑO(id_dueño, nombre, teléfono, dirección, dni)
CHOFER(id_chofer, nombre, teléfono, dirección, fecha_licencia_desde, fecha_licencia_hasta, dni)
AUTO(patente, id_dueño, id_chofer, marca, modelo, año)
VIAJE(patente, hora_desde, hora_hasta, origen, destino, tarifa, metraje)
a) Listar el dni, nombre y teléfono de todos los dueños que NO son choferes.
b) Listar la patente y el id_chofer de todos los autos a cuyos choferes les caduca la licencia el 01/01/2018.

```
a)
    A   <---    DUEÑO |X| CHOFER                // Choferes que son dueños
    B   <---    DUEÑO - A                       // Choferes que no son dueños
    C   <---    π dni, nombre, telefono (B)     // Dejo solo dni nombre y telefono

b)
    A   <---    σ fecha_licencia_hasta = 01/01/2018 (CHOFER)    // Choferes que caducan en esa fecha
    B   <---    AUTO |X| A                      // Autos de esos choferes
    C   <---    π patente, id_chofer (B)        // Dejo solo patente y id_chofer de esos autos

```

---

2) Dados los siguientes esquemas
ALUMNO(#alumno, nombre_alumno, edad, provincia, beca)
MATRICULA(#alumno, #asignatura, grupo)
ASIGNATURA (#asignatura, nombre_asignatura, grupo, año)
PROFESOR(#profesor, #asignatura, nombre_prefesor, grupo)
a) Listar el nombre de los alumnos matriculados en todas las asignaturas de segundo año.
b) Listar el #alumno de los alumnos que no estén matriculados en BBDD.

```
a)
    A   <---    σ año = 2 (ASIGNATURA)          // Asignaturas de segundo año
    B   <---    π #asignatura (B)               // Me interesa nada mas el nro de asignatura
    C   <---    π #alumno, #asignatura MATRICULA    // Me interesa solo el #alumno y #asignatura
    D   <---    C % B                           // Matriculas que cumplen con todas las asignaturas
    E   <---    ALUMNO |X| D                    // Alumnos de dichas matriculas
    F   <---    π nombre_alumno E

b)
    A   <---    σ nombre_asignatura = BBDD (ASIGNATURA)
    B   <---    π #asignatura (B)
    C   <---    MATRICULA |X| B
    D   <---    π #alumno C
    E   <---    ALUMNO |X| D
    F   <---    ALUMNO - E
    G   <---    π #alumno F
```

---

3) Dados los siguientes esquemas
TIPOMUEBLE (id_tipomueble,descripción)
FABRICANTE (id_fabricante,nombrefabricante,cuit)
TIPOMADERA (id_tipomadera,nombremadera)
AMBIENTE (id_ambiente,descripcionambiente)
MUEBLE (id_mueble, id_tipomueble, id_fabricante, id_tipomadera, precio, dimensiones, descripcion)
MUEBLEAMBIENTE (id_mueble,id_ambiente)
a) Obtener los nombres de los fabricantes que fabrican muebles en todos los tipos de Madera.
b) Obtener los nombres de los fabricantes que sólo fabrican muebles en Pino.
c) Obtener los nombres de los fabricantes que fabrican muebles para todos los ambientes.
d) Obtener los nombres de los fabricantes que sólo fabrican muebles para oficina.
e) Obtener los nombres de los fabricantes que sólo fabrican muebles para baño y cocina.
f) Obtener los nombres de los fabricantes que producen muebles de cedro y roble.
g) Obtener los nombres de los fabricantes que producen muebles de melamina o MDF.

```
a)
    A   <---    FABRICANTE |X| MUEBLE
    B   <---    π nombrefabricante, id_tipomadera A
    C   <---    π id_tipomadera TIPOMADERA
    D   <---    B % C

b)
    A   <---    σ nombremadera = "Pino" TIPOMADERA
    B   <---    π id_tipomadera A
    C   <---    MUEBLE |X| A
    D   <---    π id_fabricante C
    E   <---    FABRICANTE |X| D
    F   <---    π nombrefabricante E        // Los que fabrican de pino

    G   <---    MUEBLE - C
    H   <---    π id_fabricante G
    I   <---    FABRICANTE |X| H
    J   <---    π nombrefabricante I        // Los que fabrican de otro tipo de madera

    K   <---    F - J                       // Los que solo fabrican de pino

c)
    A   <---    MUEBLE |X| MUEBLEAMBIENTE
    B   <---    π id_fabricante, id_ambiente A
    C   <---    π id_ambiente AMBIENTE
    D   <---    B % C
    E   <---    FABRICANTE |X| D
    F   <---    π nombrefabricante E

d)
    A   <---    σ descripcionambiente = oficina AMBIENTE
    B   <---    MUEBLEAMBIENTE |X| A
    C   <---    MUEBLE |X| B
    D   <---    FABRICANTE |X| C
    E   <---    π nombrefabricante D    // Fabricantes que fabrican para oficina

    F   <---    AMBIENTE - A
    G   <---    MUEBLEAMBIENTE |X| F
    H   <---    MUEBLE |X| G
    I   <---    FABRICANTE |X| H
    J   <---    π nombrefabricante I    // Fabricantes que fabrican para no oficina

    K   <---    E - J                   // Los que fabrican solo oficina

e)
    A   <---    σ descripcionambiente = baño AMBIENTE   U   σ descripcionambiente = cocina AMBIENTE
    B   <---    MUEBLEAMBIENTE |X| A
    C   <---    MUEBLE |X| B
    D   <---    FABRICANTE |X| C
    E   <---    π nombrefabricante D

    F   <---    AMBIENTE - A
    G   <---    MUEBLEAMBIENTE |X| F
    H   <---    MUEBLE |X| G
    I   <---    FABRICANTE |X| H
    J   <---    π nombrefabricante I

    K   <---    E - J

f)
    A   <---    σ nombremadera = cedro TIPOMADERA
    B   <---    σ nombremadera = roble TIPOMADERA
    C   <---    A U B
    D   <---    π id_tipomadera C
    
    E   <---    FABRICANTE |X| MUEBLE
    F   <---    π nombrefabricante, id_tipomadera E
    G   <---    F % D

g)
    A   <---    σ nombremadera = melamina TIPOMADERA
    B   <---    σ nombremadera = MDF TIPOMADERA
    C   <---    A U B
    D   <---    π id_tipomadera C

    E   <---    FABRICANTE |X| MUEBLE
    F   <---    E |X| D
    G   <---    π nombrefabricante F
```

---

4) Dados los siguientes esquemas
CLIENTE (id_cliente, nombreCliente, puntaje, edad)
AUTOMOVIL (id_automovil, marca, color)
RESERVA (id_cliente, id_automovil, fecha)
Tener en cuenta que un cliente puede realizar diversas reservas
a) Obtener los colores de los automóviles reservados por Juan.
b) Obtener los nombres de los clientes que no han reservado un automóvil verde.
c) Obtener los nombres de los clientes que han reservado por lo menos dos automóviles.
d) Obtener el id de aquel cliente con el puntaje más alto.

```
a)
    A   <---    σ nombreCliente = "Juan" CLIENTE
    B   <---    A |X| RESERVA
    C   <---    π id_automovil B
    D   <---    AUTOMOVIL |X| C
    E   <---    π color D

b)
    A   <---    CLIENTE |X| RESERVA
    B   <---    A |X| AUTOMOVIL
    C   <---    σ color = verde B
    D   <---    π nombreCliente C
    E   <---    π nombreCliente CLIENTE
    F   <---    E - D

c)
    A   <---    P A RESERVA
    B   <---    P B RESERVA
    C   <---    A |X| A.id_cliente = B.id_cliente AND ( A.id_automovil != B.id_automovil OR A.fecha != B.fecha ) B
    D   <---    P D(id_cliente) (π A.id_cliente C)
    E   <---    CLIENTE |X| D
    F   <---    π nombreCliente E

d)
    A   <---    P a Cliente
    B   <---    P b Cliente
    C   <---    A X B
    D   <---    σ a.puntaje < b.puntaje C
    E   <---    P E(nombreCliente) (π A.nombreCliente D)
    F   <---    π nombreCliente Cliente
    G   <---    F - E
```

---

5) Dados los siguientes esquemas
ESTUDIANTE (#legajo, nombreCompleto, nacionalidad, añoDeIngreso, códigoDeCarrera)
CARRERA (códigoDeCarrera, nombre)
INSCRIPCIONAMATERIA (#legajo, códigoDeMateria)
MATERIA (códigoDeMateria, nombre)
a) Obtener el nombre de los estudiantes con nacionalidad “Argentina” que NO estén en la carrera con código “LI07”
b) Obtener el legajo de los estudiantes que se hayan anotado en TODAS las materias.

```
a)
    A   <---    σ nacionalidad = Argentina ESTUDIANTE
    B   <---    ESTUDIANTA |X| CARRERA
    C   <---    σ codigoDeCarrera = LI07 B
    D   <---    π nombreCompleto A
    E   <---    π nombreCompleto C
    F   <---    D - E

b)
    A   <---    ESTUDIANTE |X| INSCRIPCIONMATERIA
    B   <---    π codigoDeMateria MATERIA
    C   <---    A % B
    D   <---    π nombreCompleto C
```

---

6) Dados los siguientes esquemas
ALUMNO (#alumno, nombre)
CURSA (#alumno, #curso)
CURSO (#curso, nombre_curso)
PRACTICA (#practica, #curso)
ENTREGA (#alumno, #practica, nota)
a) Obtener #alumno y nombre de los alumnos que aprobaron con 7 o más todas las prácticas de los cursos que realizaron.

```
a)
    A   <---    σ nota < 7 ENTREGA
    B   <---    π #alumno A
    C   <---    ALUMNO |X| B
    D   <---    ALUMNO - C
```

---

7) Dados los siguientes esquemas
PDA (imei, marca, numero_serie)
JURISDICCIÓN (id_jurisdiccion, nombre)
CONDUCTOR (dni_conductor, nombre, apellido, id_Jurisdiccion)
TIPO_INFRACCION (codigo, descripcion, puntos, tipo)
ACTA_INFRACCION (#acta, imei, fecha, dni_conductor, id_Jurisdiccion)
INFRACCION_ACTA (#acta, codigo)
a) Obtener los códigos de los tipos de infracciones que no fueron utilizadas en las actas labradas de la jurisdicción “La Plata”.    
b) Obtener los #Actas en donde el conductor pertenezca a la misma jurisdicción del lugar del labrado del acta
c)  Obtener los imei de PDA que han labrado actas de tipo “Velocidad” sólo en la ciudad de “Mar del Plata”.

```
a)
    A   <---    σ nombre = "La Plata" JURISDICCION
    B   <---    π id_jurisdiccion A
    C   <---    ACTA_INFRACCION |X| B
    D   <---    π #acta C
    E   <---    D |X| INFRACCION_ACTA
    F   <---    π codigo E
    G   <---    π codigo INFRACCION_ACTA
    H   <---    G - F

b)
    A   <---    CONDUCTOR |X| ACTA_INFRACCION
    E   <---    π #acta D

c)
    A   <---    σ tipo = "Velocidad" TIPO_INFRACCION
    B   <---    INFRACCION_ACTA |X| A
    C   <---    π #acta B
    D   <---    ACTA_INFRACCION |X| C       // Actas de Velocidad

    E   <---    σ nombre = "Mar del Plata" JURISDICCION
    F   <---    π id_jurisdiccion E         // Jurisdiccion de Mar del Plata

    G   <---    D |X| F
    H   <---    π imei G                    // Los imei de las de velocidad y Mar Del Plata

    I   <---    σ nombre != "Mar del Plata" JURISDICCION
    J   <---    π id_jurisdiccion I         

    K   <---    D |X| J
    L   <---    π imei K                    // Los imei de las de velocidad que no fueron en Mar del Plata

    M   <---    H - L                       // Los imei que solo hicieron de velocidad en Mar del Plata

```

---

8) Dados los siguientes esquemas
USUARIO (id_usuario, email, nombre)
FORMULARIO (id_formulario, titulo, fecha_publicacion)
USUARIO_PARTICIPA (id_usuario, id_formulario)
APORTE (id_aporte, id_formulario, id_usuario, nombre, tipo, datos, valoracion)
a) Obtener los nombres de los usuarios que hicieron aportes en todos los formularios, independientemente de si participan o no en el mismo.
b) Obtener los nombres de los usuarios que han realizado aportes en todos los formularios en los que participa.
c) Obtener el identificador del usuario que realizo la publicación con mayor valoración.

```
a)
    A   <---    π id_formulario FORMULARIO
    B   <---    π id_formulario, id_usuario APORTE
    C   <---    B % A
    D   <---    USUARIO |X| C
    E   <---    π nombre D

b)
    A   <---    π id_usuario, id_formulario APORTE
    B   <---    USUARIO_PARTICIPA - A
    C   <---    USUARIO || B
    D   <---    π id_usuario, email, nombre C   // Los que participan en algun formulario en el que no aportaron
    E   <---    USUARIO - D                     // Los que aportaron a todos los que participan
    F   <---    π nombre E

c)
    A   <---    P A APORTE
    B   <---    APORTE X A
    C   <---    σ APORTE.valoracion < A.valoracion B
    D   <---    π Aporte.valoracion C
    E   <---    P E(valoracion) D
    F   <---    E |X| APORTE
    G   <---    APORTE - F
    H   <---    π id_usuario G

```

---

9) Dados los siguientes esquemas
IDIOMA (id_idioma, nombre)
DICCIONARIO (id_diccionario, id_lenguaje, fecha_version)
USUARIO (id_usuario, nombre, fecha_ingreso)
DEFINICION (id_diccionario, id_usuario, palabra, significado)
a) Obtener los nombres de los usuarios que hayan ingresado antes del 2010 y no hayan aportado ninguna definición
b) Obtener los nombres de todos los usuarios que hayan aportado alguna definición para el idioma Español
c) Obtener el nombre de los idiomas que no tengan diccionarios posteriores al 2015

```
a)
    A   <---    π id_usuario DEFINICION
    B   <---    USUARIO |X| A
    C   <---    USUARIO - B
    D   <---    σ fecha_ingreso < 2010 C
    E   <---    π nombre D

b)
    A   <---    σ nombre = "Espanol" IDIOMA
    B   <---    π id_idioma IDIOMA
    C   <---    DICCIONARIO |X| B
    D   <---    π id_diccionario C
    E   <---    DEFINICION |X| D
    F   <---    π id_usuario E
    F   <---    USUARIO |X| F
    F   <---    π nombre F

c)
    A   <---    σ fecha_version > 2015 DICCIONARIO
    B   <---    π id_lenguaje A
    C   <---    π id_lenguaje DICCIONARIO
    D   <---    C - B
    E   <---    IDIOMA |X| D
    F   <---    π nombre E

```

---

10) Dados los siguientes esquemas
VIAJE (id_viaje, fecha, hora, id_lugar_origen, id_lugar_destino, id_vehiculo)
LUGAR (id_lugar, nombre)
VEHICULO (id_vehiculo, id_usuario, capacidad)
USUARIO (id_usuario, nombre, apellido)
PASAJERO (id_viaje, id_usuario)
a) Obtener fecha y hora de los viajes posteriores al 30/11 que vayan desde La Plata hacia Rosario y que no tengan pasajeros registrados.
b) Obtener el identificador del usuario que posee el auto con la capacidad más alta.

```
a)
    A   <---    π id_lugar (σ nombre = "La Plata" LUGAR)
    B   <---    π id_lugar (σ nombre = "Rosario" LUGAR)
    C   <---    VIAJE |X| (VIAJE.id_lugar_origen = A.id_lugar) A
    D   <---    C |X| (C.id_lugar_destino = B.id_lugar) B
    E   <---    σ fecha > 30/11 D

    F   <---    π id_viaje PASAJERO
    G   <---    E |X| F          // Viajes desde y hasta con fecha posterior, que tienen algun pasajero

    H   <---    E - G           // Viajes que no.
    I   <---    π fecha, hora H

b)
    A   <---    P A VEHICULO
    B   <---    P B VEHICULO
    C   <---    A X B
    D   <---    σ A.capacidad < B.capacidad C
    E   <---    π A.id_vehiculo D
    F   <---    P F(id_vehiculo) E
    G   <---    VEHICULO |X| F
    H   <---    VEHICULO - G
    I   <---    π id_usuario H

```
