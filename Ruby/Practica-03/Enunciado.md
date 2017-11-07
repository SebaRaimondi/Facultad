# Práctica 3

--------------------------------------------------------------------------------

Esta práctica incorpora ejercicios sobre excepciones, tanto definición y manejo de las misma como un breve sondeo de las principales clases de excepción, y a su vez introduce algunos ejercicios sobre testing en Ruby.

## Excepciones

### Ejercicio 1.

Investigá la jerarquía de clases que presenta Ruby para las excepciones. ¿Para qué se utilizan las siguientes clases?

- IOError
- NameError
- RuntimeError
- NotImplementedError
- StopIteration
- TypeError
- SystemExit

--------------------------------------------------------------------------------

### Ejercicio 2.

¿Cuál es la diferencia entre raise y throw? ¿Para qué usarías una u otra opción?

--------------------------------------------------------------------------------

### Ejercicio 3.

¿Para qué sirven begin .. rescue .. else y ensure? Pensá al menos 2 casos concretos en que usarías estas sentencias en un script Ruby.

--------------------------------------------------------------------------------

### Ejercicio 4.

¿Para qué sirve retry? ¿Cómo evitarías caer en un loop infinito al usarla?

--------------------------------------------------------------------------------

### Ejercicio 5.

¿Cuáles son las diferencias entre los siguientes métodos?

```ruby
def opcion_1
    a = [1, nil, 3, nil, 5, nil, 7, nil, 9, nil]
    b = 3
    c = a.map do | x|
        x * b
    end
    puts c.inspect
rescue
    0
end

def opcion_2
    c = begin
        a = [1, nil, 3, nil, 5, nil, 7, nil, 9, nil]
        b = 3
        a.map do | x|
            x * b
        end
    rescue
        0
    end
    puts c.inspect
end

def opcion_3
    a = [1, nil, 3, nil, 5, nil, 7, nil, 9, nil]
    b = 3
    c = a.map { | x| x * b } rescue 0
    puts c.inspect
end

def opcion_4
    a = [1, nil, 3, nil, 5, nil, 7, nil, 9, nil]
    b = 3
    c = a.map { | x| x * b rescue 0 }
    puts c.inspect
end
```

--------------------------------------------------------------------------------

### Ejercicio 6.

Suponé que tenés el siguiente script y se te pide que lo hagas resiliente (tolerante a fallos), intentando siempre que se pueda recuperar la situación y volver a intentar la operación que falló. Realizá las modificaciones que consideres necesarias para lograr que el script sea más robusto.

```ruby
# Este script lee una secuencia de no menos de 15 números desde teclado y lue go imprime el resultado de la división
# de cada número por su entero inmediato anterior.
# Como primer paso se pide al usuario que indique la cantidad de números que ingresará.
cantidad = 0
while cantidad < 15
    puts '¿Cuál es la cantidad de números que ingresará? Debe ser al menos 15'
    cantidad = gets.to_i
end

# Luego se almacenan los números
numeros = 1.upto(cantidad).map do
    puts 'Ingrese un número'
    numero = gets.to_i
end

# Y finalmente se imprime cada número dividido por su número entero inmediato anterior
resultado = numeros.map { | x| x / (x - 1) }
puts 'El resultado es: %s' % resultado.join(', ')
```

--------------------------------------------------------------------------------

### Ejercicio 7.

Partiendo del script del inciso anterior, implementá una nueva clase de excepción que se utilizará para indicar que la entrada del usuario no es un valor numérico entero válido. ¿De qué clase de la jerarquía de Exception heredaría?

--------------------------------------------------------------------------------

### Ejercicio 8.

Sea el siguiente código:

```ruby
def fun3
    puts "Entrando a fun3"
    raise RuntimeError, "Excepción intencional"
    puts "Terminando fun3"
rescue NoMethodError => e
    puts "Tratando excepción por falta de método"
rescue RuntimeError => e
    puts "Tratando excepción provocada en tiempo de ejecución"
rescue
    puts "Tratando una excepción cualquiera"
ensure
    puts "Ejecutando ensure de fun3"
end

def fun2(x)
    puts "Entrando a fun2"
    fun3
    a = 5 / x
    puts "Terminando fun2"
end

def fun1(x)
    puts "Entrando a fun1"
    fun2 x
rescue
    puts "Manejador de excepciones de fun1"
    raise
ensure
    puts "Ejecutando ensure de fun1"
end

begin
    x = 0
    begin
        fun1 x
    rescue Exception => e
        puts "Manejador de excepciones de Main"
        if x == 0
            puts "Corrección de x"
            x = 1
            retry
        end
    end
    puts "Salida"
end
```

1. Seguí el flujo de ejecución registrando la traza de impresiones que deja el programa y justificando paso a paso.
2. ¿Qué pasaría si se permuta, dentro de fun3, el manejador de excepciones para RuntimeError y el manejador de excepciones genérico (el que tiene el rescue vacío)?
3. ¿La palabra reservada retry que función cumple? ¿Afectaría el funcionamiento del programa si se mueve la línea x = 0 dentro del segundo begin (inmediatamente antes de llamar a fun1 con x)?

--------------------------------------------------------------------------------
