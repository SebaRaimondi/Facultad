# Práctica 2 – Semáforos

### 1. 	Existen N personas que deben ser chequeadas por un detector de metales antes de poder ingresar al avión.

#### 	a. 	Implemente una solución que modele el acceso de las personas a un detector (es decir si el detector está libre la persona lo puede utilizar caso contrario debe esperar).

	Var
		sem libres = 1
	Process Detector[i = 1..N]::
	{	llega una persona.
		P(libres)
		pasa una persona.
		V(libres)
		ingresa al avion o le sacan la bomba.
	}


#### 	b. 	Modifique su solución para el caso que haya tres detectores.

	Var
		sem libres = 3
	Process Detector[i = 1..N]::
	{	llega una persona.
		P(libres)
		pasa una persona.
		V(libres)
		ingresa al avion o le sacan la bomba.
	}


### 2.	Un sistema operativo mantiene 5 instancias de un recurso almacenadas en una cola, cuando un proceso necesita usar una instancia del recurso la saca de la cola, la usa y cuando termina de usarla la vuelve a depositar.

	Var
		sem instLibres = 5
		sem colaLibre = 1
	Process Operativo[i = 1..N]::
	{	P(instLibres)
		P(colaLibre)
		recurso = cola.desencolar			# Necesito semaforo para usar la cola???
		V(colaLibre)
		el proceso usa la instancia del recurso.
		P(colaLibre)
		cola.encolar(recurso)				# Necesito semaforo para usar la cola???
		V(colaLibre)
		V(instLibres)
	}

### 3.	Suponga que existe una BD que puede ser accedida por 6 usuarios como máximo al mismo tiempo. Además los usuarios se clasifican como usuarios de prioridad alta y usuarios de prioridad baja. Por último la BD tiene la siguiente restricción:
* no puede haber más de 4 usuarios con prioridad alta al mismo tiempo usando la BD.
* no puede haber más de 5 usuarios con prioridad baja al mismo tiempo usando la BD.
### 	Indique si la solución presentada es la más adecuada. Justifique la respuesta.

		Var
			sem: semaphoro := 6;
			alta: semaphoro := 4;
			baja: semaphoro := 5;

		Process Usuario-Alta [I:1..L]::				
			{ 	P (sem);								
				P (alta);									
				//usa la BD									
				V(sem);										
				V(alta);									
			}											

		Process Usuario-Baja [I:1..K]::
			{ 	P (sem);
				P (baja);
				//usa la BD
				V(sem);
				V(baja);
			}

	No es la forma correcta de declarar semaforos, se declaran con "sem nombreDeSemaforo = valorInicial"
	Se tiene que hacer P(sem) luego del P(alta/baja), ya que sino podrian pasar el P(sem) 6 prio baja, 
		cuando solo 5 pasan el P(baja) y no puede ejecutarse ningun prioridad alta
	

### 4. 	Se tiene un curso con 40 alumnos, la maestra entrega una tarea distinta a cada alumno, luego cada alumno realiza su tarea y se la entrega a la maestra para que la corrija, esta revisa la tarea y si está bien le avisa al alumno que puede irse, si la tarea está mal le indica los errores, el alumno corregirá esos errores y volverá a entregarle la tarea a la maestra para que realice la corrección nuevamente, esto se repite hasta que la tarea no tenga errores.

	Var
		cola porCorregir    #Asumo que encolar y desencolar son atomicas, sino agregaria un semaforo.
		sem	sCola = 1
		int seFueron = 0
		sem sEntregados = 1
		int entregados = 0
		array[1..40] tareaPara of sem = 0
		array[1..40] corregido of sem = 0
		array[1..40] puedoIrme of boolean = false

	Process Alumno[i = 1..40]::
	{	P(tareaPara[i])				# Espero a que la maestra me de la tarea.
		while(!puedoIrme[i]) {
			hago mi tarea
			P(sCola)
			porCorregir.encolar(i)		# Le entrego mi tarea a la maestra para que la corrija.
			V(sCola)
			P(sEntregados)
			entregados++
			V(sEntregados)
			P(corregido[i])			# Espero hasta que mi tarea haya sido corregida.
		}
	}

	Process Maestra::
	{	for i = 1 to 40 do V(tareaPara[i])	# Le doy a los su tarea a cada alumno.
		while (seFueron < 40) {
			P(entregados)			# Espero hasta que haya algun entregado.
			P(sCola)
			alumnoActual = porCorregir.desencolar()		# Agarro de la cola una tarea.
			V(sCola)
			Corrijo la tarea del alumnoActual
			if laTareaEstabaBien then 
				puedoIrme[alumnoActual] = true 
				seFueron++
			endif
			V(corregido[alumnoActual])	# Le aviso al alumnoActual que ya corregi su trabajo.
		}
	}


### 5.	Suponga que se tiene un curso con 50 alumnos. Cada alumno elije una de las 10 tareas para realizar entre todos. Una vez que todos los alumnos eligieron su tarea comienzan a realizarla. Cada vez que un alumno termina su tarea le avisa al profesor y si todos los alumnos que tenían la misma tarea terminaron el profesor les otorga un puntaje que representa el orden en que se terminó esa tarea.
### Nota: Para elegir la tarea suponga que existe una función elegir que le asigna una tarea a un alumno (esta función asignará 10 tareas diferentes entre 50 alumnos, es decir, que 5 alumnos tendrán la tarea 1, otros 5 la tarea 2 y así sucesivamente para las 10 tareas).

	Var
		int eligieron = 0
		sem sEligieron = 0
		sem tareasPorAtender = 0
		array[1..10] orden of int
		array[1..10] termine of int = 0
		array[1..10] sTermine of sem = 1
		array[1..10] semOrden of sem = 0
		array[1..50] arranquen of sem = 0
	
	Process Alumno[i = 1..50]:: 
	{	tarea = elegirTarea()

		P(sEligieron)
		eligieron++
		if (eligieron == 50) then for i = 1 to 50 do V(arranquen[i]) 
		V(sElegieron)

		P(arranquen[i])
		Realizo mi tarea.

		P(sTermine[tarea])
		termine[tarea]++
		if (termine[tarea] == 5) then

			P(sCola)
			cola.encolar(tarea)
			V(sCola)

			V(tareasPorAtender)
		endif
		V(sTermine[tarea])

		P(semOrden[tarea])
		mirarMiOrden(orden[tarea])
		Me voy.
	}

	Process Profesor::
	{	for tareasAtendidas = 1 to 10 do {
			P(tareasPorAtender)
			
			P(sCola)
			tareaActual = cola.desencolar()
			V(sCola)

			orden[tareaActual] = tareasAtendidas
			for 1 to 5 { V(semOrden[tareaActual]) }
		}
	}


### 6.	A una empresa llegan E empleados y por día hay T tareas para hacer (T>E), una vez que todos los empleados llegaron empezaran a trabajar. Mientras haya tareas para hacer los empleados tomaran una y la realizarán. Cada empleado puede tardar distinto tiempo en realizar cada tarea. Al finalizar el día se le da un premio al empleado que más tareas realizó.

	Var
		sem semTareas = 1
		sem llegue = 1
		int tareas = T
		int terminadasTotales = 0
		array[1..E] terminadas of int
		array[1..E] arrancar of sem = 0

	Process Empleado[i = 1..E]::
	{	P(llegue)
		cant++
		if (cant == E) then for j = 1 to E do V(arrancar[j])
		V(llegue)

		P(arrancar[i])

		P(semTareas)
		while (tareas > 0) {
			tareas--
			V(semTareas)

			realizar tarea
			terminadas[i]++

			P(semTareas)
			terminadasTotales++
		}
		if terminadasTotales == T {
			premio = terminadas.max
			for k = 1 to E do V(terminamos[k])
		}
		V(semTareas)

		P(terminamos[k])
		if (terminadas[i] == premio) then recibirPremio()
	}


### 7. Existe una casa de comida rápida que es atendida por 1 empleado. Cuando una persona llega se pone en la cola y espera a lo sumo 10 minutos a que el empleado lo atienda. Pasado ese tiempo se retira sin realizar la compra.

	wat


### 8. Hay una fábrica con M operarios en donde se deben realizar N tareas (siendo M = Nx5). Cada tarea se realiza de a grupos de 5 operarios, ni bien llegan a la fábrica se juntan de a 5 en el orden en que llegaron y cuando se ha formado el grupo se le da la tarea correspondiente empezando de la tarea uno hasta la enésima. Una vez que los operarios del grupo tienen la tarea asignada producen elementos hasta que hayan realizado exactamente X entre los operarios del grupo. Una vez que terminaron de producir los X elementos, se juntan los 5 operarios del grupo y se retiran.
### Nota: cada operario puede hacer 0, 1 o más elementos de una tarea. El tiempo que cada operario tarda en hacer cada elemento es diferente y random. Maximice la concurrencia. 

	Var
		int grupoLibre = 1
		sem sLlegue = 1
		array[1..N] grupos of int = 0
		array[1..N] sTareas of sem = 1
		array[1..N] tareasQueFaltan = X
		array[1..N] tareasTerminadas = 0

	Process Operario[i = 1..M]::
	{	P(sLlegue)
		miGrupo = grupoLibre
		grupos[miGrupo]++
		if (grupos[miGrupo] == 5) then for 1 to 5 do { V(arranqueGrupo[miGrupo]); grupoLibre++ }
		V(sLlegue)

		P(arranqueGrupo[miGrupo])
		buscarTarea(miGrupo)

		P(sTareas[miGrupo])
		while (tareasQueFaltan[miGrupo] > 0) do {
			tareasQueFaltan[miGrupo]--
			V(sTareas[miGrupo])
			realizarTarea
			P(sTareas[miGrupo])
			tareasTerminadas[miGrupo]++
		}
		if (tareasTerminadas[miGrupo] == X) then for 1 to 5 do { P(puedeRetirarse[miGrupo]) }
		V(sTareas[miGrupo])

		V(puedeRetirarse[miGrupo])
		meVoy()
	}


### 9. Resolver con SEMÁFOROS el funcionamiento en una fábrica de ventanas con 7 empleados (4 carpinteros, 1 vidriero y 2 armadores) que trabajan de la siguiente manera:
* Los carpinteros continuamente hacen marcos (cada marco es armando por un único carpintero) y los deja en un depósito con capacidad de almacenar 30 marcos.
* El vidriero continuamente hace vidrios y los deja en otro depósito con capacidad para 50 vidrios.
* Los armador continuamente toman un marco y un vidrio de los depósitos correspondientes y arman la ventana (cada ventana es armada por un único armador).

	Var
		sem lugarMarcos = 30
		sem cantMarcos = 0
	Process Carpintero[1..4]::
	{	while (true) {
			V(lugarMarcos)
			producirMarco()
			P(cantMarcos)
		}
	}
	Process Vidriero::
	{	while (true) {
			V(lugarVidrios)
			producirVidrio()
			P(cantVidrio)
		}
	}
	Process Armador[1..2]::
	{	while (true) {
			V(cantMarcos)
			V(cantVidrio)
			armarVentana()
		}
	}


### 10.En un curso hay dos profesores que toman examen en forma oral, el profesor A llama a los alumnos de acuerdo al orden de llegada, mientras que el profesor B llama a cualquier alumno (que haya llegado). Existen N alumnos que llegan y se quedan esperando hasta ser llamados para rendir, luego de que uno de los dos profesores lo atiende, se va. Indicar si la siguiente solución realizada con semáforo resuelve lo pedido. Justificar la respuesta. 

	Var
		string estado[N] = ([N], “Esperando” )
		queue colaA, colaB
		sem llegoA, llegoB = 0
		sem esperando[N] = ([N], 0)
		sem mutex[N] = ([N], 1)
		sem mutexA, mutexB = 1
	Profesor A::
	{	int idAlumno
		while (true)
		{	P(llegoA)
			P(mutexA)
			idAlumno = pop(colaA)
			V(mutexA)
			P(mutex[idAlumno])
			If (estado[idAlumno] = =“Esperando”)
				estado[idAlumno] = “A”
				V(mutex[idAlumno])
				V(esperando[idAlumno])
				//Se toma el examen//
				V(esperando[idAlumno])
			else
				V(mutex[idAlumno])
		}
	}
	Profesor B::
	{	int idAlumno
		while (true)
		{	P(llegoB)
			P(mutexB)
			idAlumno = popAleatorio(colaB)
			V(mutex(B))
			P(mutex[idAlumno])
			If (estado[idAlumno] == “Esperando”)
				estado[idAlumno] = “B”
				V(mutex[idAlumno])
				V(esperando[idAlumno])
				//Se toma el examen//
				V(esperando[idAlumno])
			else
				V(mutex[idAlumno])
		}
	}
	Alumno[i: 1..N]
	{	P(mutexA)
		push(colaA, i)
		V(mutexA)
		P(mutexB)
		push(colaB, i)
		V(mutexB)
		P(esperando[i])
		if (estado[i] == “A”)
			//Interactúa con el Prof A//
		else
			//Interactua con el Prof B//
		P(esperando[i])
	}

	El proceso de los profesores nunca terminan
	Los alumnos no hacen V(llegoA) ni V(llegoB)
	Ambos profesores deberian usar la misma cola, accediendola de forma diferente.


### 11.Resolver el funcionamiento en una empresa de genética. Hay N clientes que sucesivamente envían secuencias de ADN a la empresa para que sean analizadas y esperan los resultados para poder envían otra secuencia a analizar. Para resolver estos análisis la empresa cuenta con 2 servidores que van alternando su uso para no exigirlos de más (en todo momento uno está trabajando y los otros dos descansando); cada 8 horas cambia en servidor con el que se trabaja. El servidor que está trabajando, toma un pedido (de a uno de acuerdo al orden de llegada de los mismos), lo resuelve y devuelve el resultado al cliente correspondiente; si al terminar ya han pasado las 8 horas despierta al próximo servidor y él descansa, sino continúa con el siguiente pedido.

	Var
		sem sServidor = 1
		sem sCola = 1
		queue cola
		sem porAnalizar = 0
		array[1..N] analisis of sem = 0
	Process Cliente[c = 1..N]::
	{	while (true) {
			P(sCola)
			cola.encolar(c)
			V(porAnalizar)
			V(sCola)
			P(analisis[c])
		}
	}
	Process Servidor[s = 1..3]
	{	while (true) {
			P(sServidor)
			while (quedaTiempo) {
				P(porAnalizar)
				P(sCola)
				actual = cola.desencolar()
				V(sCola)
				analizar(actual)
				V(analisis[actual])
			}
			V(sServidor)
			descansar()
		}
	}
