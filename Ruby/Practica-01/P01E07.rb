#	7. Dada una cadena cualquiera, y utilizando los métodos que provee la clase String, realizá
#	las siguientes operaciones sobre el string:
#		1. Imprimilo con sus caracteres en orden inverso.
#		2. Eliminá los espacios en blanco que contenga.
#		3. Convertí cada uno de sus caracteres por su correspondiente valor ASCII.
#		4. Cambiá las vocales por números (a por 4, e por 3, i por 1, o por 0, u por 6).

str = 'Una cadena cualquiera'

#		1. Imprimilo con sus caracteres en orden inverso.

p str.swapcase

#		2. Eliminá los espacios en blanco que contenga.

p str.delete(' ')

#		3. Convertí cada uno de sus caracteres por su correspondiente valor ASCII.

p str.bytes

#		4. Cambiá las vocales por números (a por 4, e por 3, i por 1, o por 0, u por 6).

p str.gsub(/[aeiou]/, 'a' => 4, 'e' => 3, 'i' => 1, 'o' => 0, 'u' => 6)
