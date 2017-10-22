Para los esquemas propuestos en cada ejercicio aplicar el proceso de normalización
Todos los esquemas ya se encuentran en 1FN. Utilizar las claves candidatas y Dependencias Funcionales provistas. 

### Ejercicio 1.
1) LIBRERIAS_ASOCIADAS ( idLibreria, nombreLibreria, idArticulo, nombreArticulo, idComponente, nombreComponente, idFabricanteArticulo, idDueño)

Donde:
* Para cada librería se conoce su identificador, el cual es único. Además se conoce su nombre, que puede repetirse en distintas librerías.
* Cada librería posee uno o varios dueños (idDueño)
* Cada librería registra los artículos (idArticulo) que tiene en su inventario. Para cada artículo de una librería se conoce su nombre.
* Los identificadores de artículos se pueden repetir en diferentes librerías, pero no dentro de una misma librería.
* Los artículos de una librería están compuestos por diversos componentes (idComponente).
* Los identificadores de componentes se pueden repetir en diferentes librerías para diferentes artículos, pero no para el mismo componente de un artículo dentro de una misma librería.
* Para cada componente de un artículo de una librería se conoce su nombre.
* Cada artículo de una librería tiene varios fabricantes que lo proveen (idFabricanteArticulo)

Clave Candidata:
Cc1: (idLibreria, idArticulo, idComponente, idFabricanteArtículo, idDueño)
DFs
idLibreria -> nombreLibreria
idLibreria, idArticulo -> nombreArticulo
idLibreria, idArticulo, idComponente-> nombreComponente

```

Dependencias Multivaluadas
    idLibreria -->> idDueño
    idLibreria, idArticulo -->> idFabricanteArticulo
    idLibreria, idArticulo -->> idComponente

LA1(**idLibreria**, idDueño)
LA2(**idLibreria**, nombreLibreria)
LA3(**idLibreria**, **idArticulo**, nombreArticulo)
LA4(**idLibreria**, **idArticulo**, idComponente, nombreComponente)
LA5(**idLibreria**, **idArticulo**, idFabricanteArticulo)

```

---

### Ejercicio 2.
2) EMPLEADO ( idEmpleado, nombreEmpleado, idOficina, nombreOficina, idResponsableOficina, cargaHorariaEnOficina, nombreResponsableOficina, añoIngresoOficina, idActividadEmpleadoOficina, nombreActividadOficina, dniEmpleado)

Donde:
* El idEmpleado es único por oficina. El mismo idEmpleado no se repite en diferentes oficinas
* Cada empleado tiene asignada una única carga horaria para la oficina en la que trabaja e ingreso a la oficina en un año determinado
* El nombre del empleado no es único, es decir puede haber más de un “Juan Perez” trabajando en una oficina
* El nombre del responsable de la oficina no es único, es decir puede haber más de un “Juan Perez” responsable de una oficina
* En una oficina existen muchos responsables (tener en cuenta que el esquema ya se encuentra en 1FN)
* Los responsables de oficina pueden repetirse para diferentes oficinas
* idActividadEmpleadoOficina es cada actividad que un empleado realiza en la oficina

Claves candidatas:
Cc1: (idEmpleado, idResponsableOficina, idActividadEmpleadoOficina)
Cc2: (dniEmpleado, idResponsableOficina, idActividadEmpleadoOficina)
Dependencias funcionales:
idOficina -> nombreOficina
idResponsableOficina, idOficina -> nombreResponsableOficina
idEmpleado -> nombreEmpleado, idOficina, añoIngresoOficina, dniEmpleado, cargaHorariaEnOficina
dniEmpleado -> nombreEmpleado, idOficina, añoIngresoOficina, idEmpleado, cargaHorariaEnOficina
idActividadEmpleadoOficina -> nombreActividadOficina

```
Dependencias Multivaluadas
    idEmpleado -->> idResponsableOficina
    idEmpleado -->> idActividadEmpleadoOficina

E1(**idOficina**, nombreOficina)
E2(**idResponsableOficina**, **idOficina**, nombreResponsableOficina)
E3(**idEmpleado**, nombreEmpleado, idOficina, añoIngresoOficina, dniEmpleado, cargaHorariaEnOficina)
E4(**idActividadEmpleadoOficina**, nombreActividadOficina)
E5(**idEmpleado**, idResponsableOficina)
E6(**idEmpleado**, idActividadEmpleadoOficina)
```

---

Para los esquemas propuestos en cada ejercicio aplicar el proceso de normalización
Tener en cuenta que los esquemas dados ya se encuentran en 1FN.

### Ejercicio 3.
3) INFORME_MEDICO (idMedico, apynMedico, tipoDocM, nroDocM, fechaNacM, matricula, direcciónM, teléfonoM, idPaciente, apynPaciente, tipoDocP, nroDocP, fechaNacP, idObraSoc, nroAfiliado, direcciónP, teléfonoP, nombreOS, direcciónOS, teléfonoOS, idÓrgano, descripción, idEstudio, resultado, fechaEstudio, informe)

Donde
* De cada médico se conoce su nombre y apellido, tipo y número de documento, fecha de nacimiento, matricula, dirección y teléfono.
* De cada paciente se conoce su nombre y apellido, tipo y número de documento, fecha de nacimiento, dirección, teléfono, obra social y número de afiliado. Cada obra social numera a sus afiliados de forma independiente, con lo cual los nroAfiliado podrían repetirse en diferentes obras sociales.
* De cada obra social se conoce su nombre, dirección y teléfono.
* Para cada órgano se conoce su descripción
* De cada estudio se registra a que paciente pertenece, que médico lo realizo, que órgano se estudio, un informe, el resultado y en qué fecha se realizó.

```
Claves candidatas:
    ??????????????

Dependencias Funcionales:
    idMedico    --> apynMedico, tipoDocM, nroDocM, fechaNacM, matricula, direccionM, telefonoM
    idPaciente  --> apynPaciente, tipoDocP, nroDocP, fechaNacP, direcciónP, teléfonoP, idObraSoc, nroAfiliado
    idObraSoc   --> nombreOS, direcciónOS, teléfonoOS
    idOrgano    --> descripción
    idEstudio   --> idPaciente, idMedico, idOrgano, informe, resultado, fechaEstudio
    ????    idObraSoc, nroAfiliado  --> idPaciente, blablabla   ???? (Creo que no igual porque podes no tener obra social)

Dependencias Multivaluadas:
    idEstudio   -->> idMedico
    idEstduio   -->> idÓrgano

IM1(**idMedico**, apynMedico, tipoDocM, nroDocM, fechaNacM, matricula, direcciónM, teléfonoM)
IM2(**idPaciente**, apynPaciente, tipoDocP, nroDocP, fechaNacP, direcciónP, teléfonoP, idObraSoc, nroAfiliado)
IM3(**idObraSoc**, nombreOS, direcciónOS, teléfonoOS)
IM4(**idÓrgano**, descripción)
IM5(**idEstudio**, idPaciente, informe, resultado, fechaEstudio)
IM6(**idEstudio**, idMedico)
IM7(**idEstudio**, idOrgano)
```

---

### Ejercicio 4.

```
```

---

### Ejercicio 5.

```
```

---

### Ejercicio 6.

```
```

---

### Ejercicio 7.

```
```

---

### Ejercicio 8.

```
```

---

### Ejercicio 9.

```
```

---

### Ejercicio 10.

```
```

---

### Ejercicio 11.

```
```

---
