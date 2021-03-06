Para los esquemas propuestos en cada ejercicio aplicar el proceso de normalización Todos los esquemas ya se encuentran en 1FN. Utilizar las claves candidatas y Dependencias Funcionales provistas.

# Ejercicio 1.

1) LIBRERIAS_ASOCIADAS ( idLibreria, nombreLibreria, idArticulo, nombreArticulo, idComponente, nombreComponente, idFabricanteArticulo, idDueño)

Donde:

- Para cada librería se conoce su identificador, el cual es único. Además se conoce su nombre, que puede repetirse en distintas librerías.
- Cada librería posee uno o varios dueños (idDueño)
- Cada librería registra los artículos (idArticulo) que tiene en su inventario. Para cada artículo de una librería se conoce su nombre.
- Los identificadores de artículos se pueden repetir en diferentes librerías, pero no dentro de una misma librería.
- Los artículos de una librería están compuestos por diversos componentes (idComponente).
- Los identificadores de componentes se pueden repetir en diferentes librerías para diferentes artículos, pero no para el mismo componente de un artículo dentro de una misma librería.
- Para cada componente de un artículo de una librería se conoce su nombre.
- Cada artículo de una librería tiene varios fabricantes que lo proveen (idFabricanteArticulo)

Clave Candidata: Cc1: (idLibreria, idArticulo, idComponente, idFabricanteArtículo, idDueño) DFs idLibreria -> nombreLibreria idLibreria, idArticulo -> nombreArticulo idLibreria, idArticulo, idComponente-> nombreComponente

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

--------------------------------------------------------------------------------

# Ejercicio 2.

2) EMPLEADO ( idEmpleado, nombreEmpleado, idOficina, nombreOficina, idResponsableOficina, cargaHorariaEnOficina, nombreResponsableOficina, añoIngresoOficina, idActividadEmpleadoOficina, nombreActividadOficina, dniEmpleado)

Donde:

- El idEmpleado es único por oficina. El mismo idEmpleado no se repite en diferentes oficinas
- Cada empleado tiene asignada una única carga horaria para la oficina en la que trabaja e ingreso a la oficina en un año determinado
- El nombre del empleado no es único, es decir puede haber más de un "Juan Perez" trabajando en una oficina
- El nombre del responsable de la oficina no es único, es decir puede haber más de un "Juan Perez" responsable de una oficina
- En una oficina existen muchos responsables (tener en cuenta que el esquema ya se encuentra en 1FN)
- Los responsables de oficina pueden repetirse para diferentes oficinas
- idActividadEmpleadoOficina es cada actividad que un empleado realiza en la oficina

Claves candidatas: Cc1: (idEmpleado, idResponsableOficina, idActividadEmpleadoOficina) Cc2: (dniEmpleado, idResponsableOficina, idActividadEmpleadoOficina) Dependencias funcionales: idOficina -> nombreOficina idResponsableOficina, idOficina -> nombreResponsableOficina idEmpleado -> nombreEmpleado, idOficina, añoIngresoOficina, dniEmpleado, cargaHorariaEnOficina dniEmpleado -> nombreEmpleado, idOficina, añoIngresoOficina, idEmpleado, cargaHorariaEnOficina idActividadEmpleadoOficina -> nombreActividadOficina

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

--------------------------------------------------------------------------------

Para los esquemas propuestos en cada ejercicio aplicar el proceso de normalización Tener en cuenta que los esquemas dados ya se encuentran en 1FN.

# Ejercicio 3.

3) INFORME_MEDICO (idMedico, apynMedico, tipoDocM, nroDocM, fechaNacM, matricula, direcciónM, teléfonoM, idPaciente, apynPaciente, tipoDocP, nroDocP, fechaNacP, idObraSoc, nroAfiliado, direcciónP, teléfonoP, nombreOS, direcciónOS, teléfonoOS, idÓrgano, descripción, idEstudio, resultado, fechaEstudio, informe)

Donde

- De cada médico se conoce su nombre y apellido, tipo y número de documento, fecha de nacimiento, matricula, dirección y teléfono.
- De cada paciente se conoce su nombre y apellido, tipo y número de documento, fecha de nacimiento, dirección, teléfono, obra social y número de afiliado. Cada obra social numera a sus afiliados de forma independiente, con lo cual los nroAfiliado podrían repetirse en diferentes obras sociales.
- De cada obra social se conoce su nombre, dirección y teléfono.
- Para cada órgano se conoce su descripción
- De cada estudio se registra a que paciente pertenece, que médico lo realizo, que órgano se estudio, un informe, el resultado y en qué fecha se realizó.

```
Claves candidatas:
    ????    Cc1: (idMedico)    ????

Dependencias Funcionales:
    idMedico    --> apynMedico, tipoDocM, nroDocM, fechaNacM, matricula, direccionM, telefonoM
    idPaciente  --> apynPaciente, tipoDocP, nroDocP, fechaNacP, direcciónP, teléfonoP, idObraSoc, nroAfiliado
    idObraSoc   --> nombreOS, direcciónOS, teléfonoOS
    idOrgano    --> descripción
    idEstudio   --> idPaciente, idMedico, idOrgano, informe, resultado, fechaEstudio

    tipoDocM, nroDocM   --> idMedico, blabla
    matricula           --> idMedico, blabla
    tipoDocP, nroDocP   --> idPaciente, blabla
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

--------------------------------------------------------------------------------

# Ejercicio 4.

4) AEROPUERTO (#aeropuerto, #pista, fecha, #avion) Donde

- # aeropuerto y #avion son únicos, pero el #pista se puede repetir para distintos aeropuertos.

- fecha representa la fecha de despegue de un avión. Cada avión tiene como máximo un despegue diario en un mismo aeropuerto.

- Un avión puede realizar despegues de distintos aeropuertos

```
Claves Candidatas:
    #aeropuerto, #avion, fecha

Dependencias Funcionales:
    #aeropuerto, #avion, fecha  --> #pista

Dependencias Multivaluadas:
    ????    Ninguna     ????

A1(#aeropuerto, #pista, fecha, #avion)
```

--------------------------------------------------------------------------------

# Ejercicio 5.

5) DISPOSITIVOS (Marca_id, descripMarca, modelo_id, descripModelo, equipo_tipo_id, descripEquipoTipo, empresa_id, nombreEmpresa, cuit, direcciónEmpresa, usuario_id, apyn, nro_doc, direcciónUsuario, cuil, plan_id, descripPlan, importe, equipo_id, imei, fec_alta, fec_baja, observaciones, línea_id, nroContrato, fec_alta_linea, fec_baja_linea)

Donde

- Para cada equipo interesa conocer su tipo, modelo, imei, fecha en que se dio de alta, fecha en que se da de baja y las observaciones que sean necesarias.
- De cada marca se conoce su descripción
- De cada modelo se conoce su descripción y a que marca pertenece.
- Para cada plan, se registra que empresa lo brinda, la descripción e importe del mismo.
- Para cada tipo de equipo se conoce la descripción
- Para cada empresa se registra el nombre, cuit y dirección
- De cada usuario se registra su nombre y apellido, número de documento, dirección y cuil.
- Para cada línea se necesita registrar el número de contrato, que plan posee, la fecha de alta de la línea, la fecha de baja, el equipo que la posee y el usuario de la misma.

```
Claves Candidatas
    linea_id

Dependencias Funcionales
    equipo_id       --> equipo_tipo_id, modelo_id, imei, fec_alta, fec_baja, observaciones
    imei            --> equipo_tipo_id, modelo_id, equipo_id, fec_alta, fec_baja, observaciones
    Marca_id        --> descripMarca
    modelo_id       --> descripModelo, Marca_id
    plan_id         --> empresa_id, descripPlan, importe
    equipo_tipo_id  --> descripEquipoTipo
    empresa_id      --> nombreEmpresa, cuit, direcciónEmpresa
    cuit            --> nombreEmpresa, empresa_id, direcciónEmpresa
    usuario_id      --> apyn, nro_doc, direcciónUsuario, cuil
    nro_doc         --> apyn, usuario_id, direcciónUsuario, cuil
    cuil            --> apyn, nro_doc, direcciónUsuario, usuario_id
    línea_id        --> nroContrato, plan_id, fec_alta_linea, fec_baja_linea, equipo_id, usuario_id

Dependencias Multivaluadas
    ----    ----    ----

DISPOSITIVOS (Marca_id, modelo_id, equipo_tipo_id, empresa_id, usuario_id, plan_id, equipo_id, línea_id,)

D1(equipo_id, equipo_tipo_id, modelo_id, imei, fec_alta, fec_baja, observaciones)
D2(Marca_id, descripMarca)
D3(modelo_id, descripModelo, Marca_id)
D4(plan_id, empresa_id, descripPlan, importe)
D5(equipo_tipo_id, descripEquipoTipo)
D6(empresa_id, nombreEmpresa, cuit, direcciónEmpresa)
D7(usuario_id, apyn, nro_doc, direcciónUsuario, cuil)
D8(línea_id, nroContrato, plan_id, fec_alta_linea, fec_baja_linea, equipo_id, usuario_id)
```

--------------------------------------------------------------------------------

# Ejercicio 6.

6) TOMAS_FOTOGRAFICAS ( idElemento, descripcionElemento, idFoto, fechaFoto, obturacionCamaraFoto, idCamara, caracteristicaTecnicaCamara, descripcionCaracteristica)

Donde

- Cuando se toma una fotografía, se indican todos los elementos que aparecen en ella, se registra la cámara con la que se tomó, el valor de obturación del lente de la cámara y todas las características técnicas de la cámara con la que se toma la foto.
- En una foto puede haber varios elementos, un elemento puede aparecer en varias fotos, pero en una misma foto solo parece una vez
- El idElemento y el idFoto son únicos en el sistema
- obturacionCamaraFoto es la obturación del lente de la cámara usada en una foto
- caracteristicaTecnicasCamara es una característica técnica de una cámara. Cada cámara puede tener muchas características, pero tener en cuenta que la misma característica NO pertenece a mas de una cámara. Dos caracteristicaTecnicasCamara pueden tener la misma descripción pero pertenecerán a cámaras diferentes.

```

Claves Candidatas
    idFoto

Dependencias Funcionales
    idFoto      --> idCamara, obturacionCamaraFoto, fechaFoto
    idElemento  --> descripcionElemento
    caracteristicaTecnicaCamara --> idCamara, descripcionCamara

Dependencias Multivaluadas
    idFoto      ->> idElemento
    idElemento  ->> idFoto
    idFoto      ->> caracteristicaTecnicaCamara

TF1(**idFoto**, idCamara, obturacionCamaraFoto, fechaFoto)
TF3(**idFoto**, **idElemento**)
TF4(**idFoto**, **caracteristicaTecnicaCamara**)
TF2(**idElemento**, descripcionElemento)
TF4(**caracteristicaTecnicaCamara**, **idCamara**, descripcionCaracteristica)
```

--------------------------------------------------------------------------------

# Ejercicio 7.

7) EMPRESA_COLECTIVO (#Línea, #Ramal, #Colectivo, dniChofer, dniInspector, dniEmpleado, nombreLinea, nombreChofer, nombreInspector, nombreEmpleado)

Donde

- Una línea posee varios ramales
- Los #Ramal no se repiten en distintas líneas
- Los #Colectivo se repiten en distintas líneas
- Los choferes están asignados a un único ramal
- Cada colectivo de una línea está asignado a un único ramal.
- Para cada ramal existe al menos un chofer asignado.

```
Dependencias Funcionales
    df1: #Linea              --> nombreLinea
    df2: dniChofer           --> #Ramal, nombreChofer
    df3: dniInspector        --> nombreInspector
    df4: dniEmpleado         --> nombreEmpleado
    df5: #Ramal              --> #Linea
    df6: #Colectivo, #Linea  --> #Ramal

Claves Candidatas
    Cc1: {dniChofer, dniInspector, dniEmpleado, #Colectivo}

EMPRESA_COLECTIVO cumple con la definicion de BCNF?
    No, ya que al menos encontramos la df1 donde #Linea no es superclave del esquema EMPRESA_COLECTIVO y sabemos que se puede particionar para eliminar anomalias.

    R1(#Linea, nombreLinea)
    R2(#Línea, #Ramal, #Colectivo, dniChofer, dniInspector, dniEmpleado, nombreChofer, nombreInspector, nombreEmpleado)

a. Perdi informacion?
    No, porque R1 ∩ R2 = #Linea, que es clave en R1

b. Perdi dependencias funcionales?
    No, porque en R1 vale df1 y en R2 valen df2, df3, df4, df5 y df6

c. R1 cumple con la definicion de BCNF?
    Si, porque el determinante de la df1 es superclave en R1

d. R2 cumple con la definicion de BCNF?
    No, porque al menos encontramos la df2 donde dniChofer no es superclave en R2.

    R3(dniChofer, #Ramal, nombreChofer)
    R4(#Línea, #Colectivo, dniChofer, dniInspector, dniEmpleado, nombreInspector, nombreEmpleado)

a. Perdi informacion?
    No, porque R3 ∩ R4 = dniChofer, que es clave en R3

b. Perdi dependencias funcionales?
    En R3 vale df2, en R4 valen df3 y df4, pero los atributos de las dependencias funcionales 5 y 6 quedaron distribuidos en mas de una particion, por lo que es necesario aplicar el algoritmo para analizar la perdida de dependencias funcionales.
    Se comprueba que se pierde la dependencias funcionales, por lo cual no se puede llevar a BCNF. Intento llevarlo a 3FN

    R5(dniInspector, nombreInspector)
    R6(dniEmpleado, nombreEmpleado)
    R7(#Ramal, #Linea)
    R8(#Colectivo, #Linea, #Ramal)

Como la clave del esquema original no esta incluido en ninguna de las particiones generadas durante el proceso, se construye una tabla con la clave:

    R9(#Colectivo, dniChofer, dniInspector, dniEmpleado)

Las particiones del esquema en 3FN son:
    R1(#Linea, nombreLinea)
    R3(dniChofer, #Ramal, nombreChofer)
    R5(dniInspector, nombreInspector)
    R6(dniEmpleado, nombreEmpleado)
    R7(#Ramal, #Linea)
    R8(#Colectivo, #Linea, #Ramal)
    R9(#Colectivo, dniChofer, dniInspector, dniEmpleado)

Clave Primaria: {#Colectivo, dniChofer, dniInspector, dniEmpleado}

Dependencias Multivaluadas
    dm1: #Linea      -->> #Ramal
    dm2: #Colectivo  -->> #Linea, #Ramal
    dm3: #Ramal      -->> dniChofer
    dm4: Ø   -->> dniInspector
    dm5: Ø   -->> dniEmpleado

En R7 encontramos la dm1 pero es trivial.
En R8 encontramos la dm2 pero es trivial.
En R3 encontramos la dm3 pero es trivial.

R9 no esta en 4FN ya que en ella valen dm5, dm6 que no son triviales. Particiono R9
    R10(dniInspector)
    R11(dniEmpleado)
    R12(#Colectivo, dniChofer)

En R10 encontramos la dm4 pero es trivial.
En R11 encontramos la dm5 pero es trivial.

Particiones finales:
    R1(#Linea, nombreLinea)
    R3(dniChofer, #Ramal, nombreChofer)
    R5(dniInspector, nombreInspector)
    R6(dniEmpleado, nombreEmpleado)
    R7(#Ramal, #Linea)
    R8(#Colectivo, #Linea, #Ramal)
    R10(dniInspector)
    R11(dniEmpleado)
    R12(#Colectivo, dniChofer)
```

--------------------------------------------------------------------------------

# Ejercicio 8.

8) INTERNACION (codHospital, cantidadHabitaciones, direcciónInternacionPaciente, telefonoInternacionPaciente, dniPaciente, domicilioPaciente, nombreApellidoPaciente, domicilioHospital, ciudadHospital, directorHospital, fechaInicioInternacion, cantDiasIntenacion, doctorQueAtiendePaciente, insumoEmpleadoInternación)

Donde

- cantidadHabitaciones es la cantidad de habitaciones que hay en cada hospital
- direcciónInternacionPaciente y telefonoInternacionPaciente, indican la dirección y el teléfono que deja un paciente cuando se interna
- domicilioPaciente es el domicilio que figura en el dni del paciente
- Un paciente para una internación es atendido por muchos doctores (doctorQueAtiendePaciente)
- Para una internación de un paciente, se emplean varios insumos (insumoEmpleadoInternación)
- El código de hospital (codHospital) es único.
- Existe un único director por hospital. Un director podría dirigir mas de un hospital
- Un paciente en la misma fecha no puede estar internado en diferentes hospitales
- En un domicilioHospital de una ciudad existe un único hospital

```
Claves Candidatas


Dependencias Funcionales
    codHospital     --> cantidadHabitaciones, directorHospital, domicilioHospital, ciudadHospital
    dniPaciente, fechaInicioInternacion --> direccionInternacionPaciente, telefonoInternacionPaciente, cantDiasInternacion, codHospital
    dniPaciente     --> domicilioPaciente, nombreApellidoPaciente


Dependencias Multivaluadas
    dniPaciente, fechaInicioInternacion -->> doctorQueAtiendePaciente
    dniPaciente, fechaInicioInternacion -->> insumoEmpleadoInternacion
    directorHospital    -->> codHospital


I1(codHospital, cantidadHabitaciones, directorHospital, domicilioHospital, ciudadHospital)
I2(dniPaciente, domicilioPaciente, nombreApellidoPaciente)
I3(dniPaciente, fechaInicioInternacion, direccionInternacionPaciente, telefonoInternacionPaciente, cantDiasInternacion, codHospital)
I4(dniPaciente, fechaInicioInternacion, doctorQueAtiendePaciente)
I5(dniPaciente, fechaInicioInternacion, insumoEmpleadoInternacion)
```

--------------------------------------------------------------------------------

# Ejercicio 9.

9) INFRACCIONES_REALIZADAS (#auto, modeloAuto, #cedula, #conductor, fechaVto, #propietario, #infraccion, fechaInfraccion, tipoInfraccion)

Donde

- un auto tiene una o más cédulas asociadas que corresponden a los conductores autorizados. Cada cédula se asocia a un único auto y a un único conductor, y tiene una fecha de vencimiento.
- los #cedula y #conductor son únicos en el sistema. Si bien un conductor puede conducir varios autos, para cada uno de ellos tendrá una cédula diferente.
- un auto puede tener más de un propietario y un propietario puede tener más de un auto.
- de cada infracción que se labra se registra el número de cedula del conductor del auto. Además se conoce la fecha y el tipo de infracción.

```
INFRACCIONES_REALIZADAS (#auto, modeloAuto, #cedula, #conductor, fechaVto, #propietario, #infraccion, fechaInfraccion, tipoInfraccion)

Se pueden deducir las siguientes dependencias funcionales:
    df1: #auto          --> modeloAuto
    df2: #cedula        --> #conductor, #auto, fechaVto
    df3: #infraccion    --> #cedula, fechaInfraccion, tipoInfraccion

Claves Candidatas
    Cc1: {#propietario, #infraccion}

INFRACCIONES_REALIZADAS cumple con la definicion de BCNF?
    No, ya que al menos encontramos a la df1, donde #auto no es superclave del esquema y sabemos que se puede particionar para eliminar anomalias, procedemos a particionar contemplando la df1:

    R1(#auto, modeloAuto)
    R2(#auto, #cedula, #conductor, fechaVto, #propietario, #infraccion, fechaInfraccion, tipoInfraccion)

a. Perdi informacion?
    No, porque R1 ∩ R2 = #auto, que es clave en R1

b. Perdi dependencias funcionales?
    No, porque en R1 vale df1 y en R2 valen df2 y df3

c. R1 cumple con la definicion de BCNF?
    Si, porque el determinante de la df1 es superclave en R1

d. R2 cumple con la definicion de BCNF?
    No, porque al menos encontramos la df2 donde #cedula no es superclave en R2.

    R3(#cedula, #conductor, #auto, fechaVto)
    R4(#cedula, #propietario, #infraccion, fechaInfraccion, tipoInfraccion)

a. Perdi informacion?
    No, porque R3 ∩ R4 = #cedula, que es clave en R3

b. Perdi dependencias funcionales?
    No, porque en R3 vale df2 y en R4 vale df3

c. R3 cumple con la definicion de BCNF?
    Si, porque el determinante de la df2 es superclave en R3

d. R4 cumple con la definicion de BCNF?
    No, porque al menos encontramos la df3 donde #infraccion no es superclave en R4.

    R5(#infraccion, #cedula, fechaInfraccion, tipoInfraccion)
    R6(#propietario, #infraccion)

a. Perdi informacion?
    No, porque R5 ∩ R6 = #infraccion, que es clave en R5

b. Perdi dependencias funcionales?
    No, porque en R5 vale df3

c. R1 cumple con la definicion de BCNF?
    Si, porque el determinante de la df3 es superclave en R5

d. R2 cumple con la definicion de BCNF?
    Si, porque representa la clave del esquema, por lo cual todas las dependencias funcionales que se puedan llegar a plantear sobre el mismo seran triviales.

Las particiones que quedaron en BCNF son:
    R1(#auto, modeloAuto)
    R3(#cedula, #conductor, #auto, fechaVto)
    R5(#infraccion, #cedula, fechaInfraccion, tipoInfraccion)
    R6(#propietario, #infraccion)

Clave Primaria: {#propietario, #infraccion}

En R1, R3 y R5 no vale ninguna dependencia multivaluada no trivial, por ese motivo se puede decir que estas particiones estan en 4FN.
En R6 existe la dependencia multivaluada #propietario -->> #infraccion, la cual es trivial en R6, por lo tanto esta en 4FN.
```

--------------------------------------------------------------------------------

# Ejercicio 10.

10) RESERVA (#Reserva, #Agencia, nombreAgencia, fechaReservaVuelo, ciudadOrigen, ciudadDestino, tipoPago, nombreAerolínea, #Vuelo, dniPasajero, nombrePasajero, dirPasajero, telPasajero, clase, fechaPartida, fechaLlegada, horaPartida, horaLlegada, modeloAvión, #Asiento, tipoComida, compañíaPasajero, dirCompañía, telCompañía)

Donde

- Una reserva puede involucrar uno o varios pasajeros (por ejemplo un tour).
- Si bien todos los pasajeros de una reserva viajan en la misma clase del mismo vuelo, cada uno de ellos decide el tipo de pago de su asiento (El tipo de pago se refiere al la forma de pago: efectivo, tarjeta de crédito, etc.). Notar que para cada vuelo el tipo pago puede ser potencialmente diferente.
- Una reserva puede involucrar muchos vuelos (por ejemplo para desplazarse de A a C se debe pasar por una escala intermedia B); tener en cuenta que no necesariamente todos los pasajeros de una reserva viajan en todos lo vuelos de esa reserva. Para cada vuelo de una reserva se conoce la fecha para la cual se realiza. Para una fecha puede haber varios vuelos de una o varias reservas.
- La reserva es realizada a través de una única agencia de turismo.
- Los pasajeros pueden estar independientemente involucrados en distintas reservas.
- Cada aerolínea maneja su propia forma de asignar el #Reserva, con lo cuál no hay garantía que estos no se repitan para las distintas aerolíneas.
- Las aerolíneas siempre usan el mismo modelo de avión para el mismo vuelo. Y el mismo vuelo de una aerolínea siempre sale de la misma ciudad a la misma hora, y llega a la misma ciudad destino a la misma hora de llegada, los días que ese vuelo es ofrecido por la aerolínea.
- El tipo de comida significa si corresponde desayuno, almuerzo, cena o merienda o cualquier combinación de ellos para cada vuelo.
- Para cada reserva de un pasajero se conoce el domicilio del pasajero y datos de su lugar de trabajo. Un pasajero puede trabajar en más de una compañía, una compañía puede tener más de una dirección y en cada dirección de una compañía puede haber más de un teléfono.

```
Clave Primaria
    {#Reserva, nombreAerolinea, #Vuelo, dniPasajero, dirCompañia, telCompañia       }

Dependencias Funcionales
    dniPasajero                 --> nombrePasajero, telPasajero
    #Agencia                    --> nombreAgencia
    nombreAerolínea, #Reserva   --> #Agencia
    nombreAerolínea, #Vuelo     --> ciudadOrigen, ciudadDestino, horaPartida, horaLlegada, modeloAvion
    nombreAerolinea, #Reserva, #Vuelo               --> clase, fechaReservaVuelo, fechaPartida, fechaLlegada
    nombreAerolinea, #Reserva, #Vuelo, dniPasajero  --> #Asiento, tipoPago
    nombreAerolinea, #Reserva, dniPasajero  --> dirPasajero

Dependencias Multivaluadas
    nombreAerolínea, #Reserva, dniPasajero  -->> #Vuelo
    nombreAerolinea, #Vuelo                 -->> fechaPartida, fechaLlegada
    nombreAerolinea, #Vuelo                 -->> tipoComida
    dniPasajero                             -->> nombreAerolinea, #Reserva     (dm1)
    dniPasajero                             -->> compañiaPasajero
    compañiaPasajero                        -->> dirCompañia
    dirCompañia                             -->> telCompañia

R1(dniPasajero, nombrePasajero, telPasajero)
R2(#Agencia, nombreAgencia)
R3(nombreAerolinea, #Reserva, #Agencia)
R4(nombreAerolinea, #Vuelo, ciudadOrigen, ciudadDestino, horaPartida, horaLlegada, modeloAvion)
R5(nombreAerolinea, #Reserva, #Vuelo, clase, fechaReservaVuelo, fechaPartida, fechaLlegada)
R6(nombreAerolinea, #Reserva, #Vuelo, dniPasajero, #Asiento, tipoPago)
R7(nombreAerolinea, #Reserva, dniPasajero, dirPasajero)

Dependencias Multivaluadas
    nombreAerolinea, #Vuelo -->> tipoComida
    #Reserva, nombreAerolinea, #Vuelo, dniPasajero -->> compañiaPasajero
    #Reserva, nombreAerolinea, #Vuelo, dniPasajero, compañiaPasajero -->> dirCompañia
    #Reserva, nombreAerolinea, #Vuelo, dniPasajero, compañiaPasajero, dirCompañia-->> telCompañia

R8(nombreAerolinea, #Vuelo, tipoComida)
R9(#Reserva, nombreAerolinea, #Vuelo, dniPasajero, compañiaPasajero, dirCompañia, telCompañia)
```

--------------------------------------------------------------------------------

# Ejercicio 11.

11) BUQUE (nombreBuque, nYApDueño, dniDueño, tipoBuque, tonelaje, tipoCasco, #Viaje, puertoOrigen, puertoDestino puertoIntermedio, nomPaísPuertoDestino, nombrePaisPuertoOrigen, nombrePaisPuertoIntermedio, posicionActual, fechaPosicionActual, nYApPasajero, dniPasajero, dirPasajero, puertoInicioPasajero, puertoFinalPasajero)

Donde

- El #Viaje es un número consecutivo que identifica cada partida de cada buque.
- Un buque hace varios viajes. El #Viaje se puede repetir para distintos buques
- Un buque puede tener varios dueños.
- El nombre del buque es único. Un nombreBuque se asocia a un tipo de buque.
- El tonelaje y el casco están determinados por el tipo de buque.
- Un buque reporta su posición una vez por día independientemente del viaje.
- Cada viaje de un buque tiene un puerto origen, un puerto destino y varios puertos intermedios.
- Un buque en su viaje puede pasar por varios puertos intermedios sin repetirlos.
- Un pasajero tiene una única dirección independientemente del viaje.
- Un pasajero tiene un único puerto origen y puerto destino por cada viaje de un buque.

```
Claves Candidatas


Dependencias Funcionales
    dniDueño                            --> nYApDueño
    nombreBuque                         --> tipoBuque
    tipoBuque                           --> tonelaje, tipoCasco
    nombreBuque, #Viaje                 --> nombrePaisPuertoOrigen, puertoOrigen, nombrePaisPuertoDestino, puertoDestino
    dniPasajero                         --> nYApPasajero, dirPasajero
    nombreBuque, #Viaje, dniPasajero    --> puertoInicioPasajero, puertoFinalPasajero
    nombreBuque, fechaPosicionActual    --> posicionActual                      (dm3?)

Dependencias Multivaluadas
    nombreBuque         -->> #Viaje
    nombreBuque         -->> dniDueño
    nombreBuque         -->> posicionActual, fechaPosicionActual                (ultima df?)
    nombreBuque, #Viaje -->> nombrePaisPuertoIntermedio, puertoIntermedio


B1(dniDueño, nYApDueño)
B2(nombreBuque, tipoBuque)
B3(tipoBuque, tonelaje, tipoCasco)
B4(nombreBuque, #Viaje, nombrePaisPuertoOrigen, puertoOrigen, nombrePaisPuertoDestino, puertoDestino)
B5(dniPasajero, nYApPasajero, dirPasajero)
B6(nombreBuque, #Viaje, dniPasajero, puertoInicioPasajero, puertoFinalPasajero)
B7(nombreBuque, #Viaje)
B8(nombreBuque, dniDueño)
B9(nombreBuque, fechaPosicionActual, posicionActual)
B10(nombreBuque, #Viaje, nombrePaisPuertoIntermedio, puertoIntermedio)
```

--------------------------------------------------------------------------------
