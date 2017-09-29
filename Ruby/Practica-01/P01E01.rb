#	Investigá y probá en un intérprete de Ruby cómo crear objetos de los siguientes tipos
#	básicos usando literales y usando el constructor new (cuando sea posible):
#	1. 	Arreglo (Array)
#	2. 	Diccionario o hash (Hash)
#	3. 	String (String)
#	4. 	Símbolo (Symbol)

#	1.	Arreglo

arreglo = [1, 'two', 3.0]	#=> [1, "two", 3.0]
arreglo = []	#=> []

#	2.	Diccionario o hash (Hash)

dic = { 'index_1' => 1, 'index_2' => 2 }
dic = { index_1: 1, index_2: 2 }
dic = {}

#	3. 	String (String)

str = 'Hello world'
str = ''	#=> ""

#	4. 	Símbolo (Symbol)

symbol = :sym
