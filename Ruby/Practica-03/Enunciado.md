# Práctica 3

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

```
IOError:
    Se lanza cuando falla una operacion de Entrada/Salida (In/Out). (Algunas operaciones IO lanzan SystemCallError).

NameError:
    Cuando un nombre es invalido o indefinido.
    Ejemplos:
        puts foo, sin antes haber definido al funcion foo,
        Setear una constante con nombre en minuscula.

RuntimeError:
    Error generico, se lanza cuando se intenta realizar una operacion invalida.
    Cuando se usa raise sin especificar clase de error, por defecto se lanza RuntimeError.

NotImplementedError:
    Se lanzan cuando una funcionalidad no esta implementada en la plataforma actual.

StopIteration:
    Se lanza para frenar una iteracion. Es la excepcion que Enumerator.next lanza cuando no quedan elementos.

TypeError:
    Se lanza cuando se encuentra un objeto que no es del tipo esperado.

SystemExit:
    Lanzado por exit para iniciar la terminacion del script.
```

--------------------------------------------------------------------------------

### Ejercicio 2.

¿Cuál es la diferencia entre raise y throw? ¿Para qué usarías una u otra opción?

```ruby
throw / catch
    # Son instrucciones de control de flujo de ejecucion del programa. (de de de)
    # Permiten salir de bloques hasta el punto en el que se haya definido un catch para un simbolo especifico.

raise / rescue
    # Sirven para el manejo real de excepciones que involucran el objeto Exception.
    # Si la excepcion no hereda de StandardError no va a ser rescatada por defecto.
```

--------------------------------------------------------------------------------

### Ejercicio 3.

¿Para qué sirven begin .. rescue .. else y ensure? Pensá al menos 2 casos concretos en que usarías estas sentencias en un script Ruby.

- `begin`:

  - Indica que el siguiente codigo puede lanzar una excepcion.

- `rescue`:

  - Indica el codigo que se debe ejecutar para un tipo de excepcion particular.

- `else`:

  - Indica codigo que se ejecuta si no se lanza ninguna excepcion.

- `ensure`:

  - Indica codigo que siempre se ejecutara, se hayan lanzado excepciones o no.

--------------------------------------------------------------------------------

### Ejercicio 4.

¿Para qué sirve retry? ¿Cómo evitarías caer en un loop infinito al usarla?

- Vuelve a empezar desde el principio del begin. Se puede agregar una variable en la que cuento cuantos intentos se realizaron y hacer retry if (cantidad < cantMax)

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

- `opcion_1`:

  - Retorna 0, ya que el metodo * no esta definido en nil. No se ejecuta puts.

- `opcion_2`:

  - c = 0 ya que se lanza una excepcion cuandos e intenta hacer nil*3.
  - Se ejecuta puts 0 y retorna nil.

- `opcion_3`:

  - Idem 2, la ejecucion del map lanza un error y por lo tanto c = 0.
  - Luego se ejecuta puts 0 y returna nil.

- `opcion_4`:

  - Como el rescue se encuentra dentro del bloque de map, cuando se la operacion x*b lance una excepcion se rescata devolviendo 0, por lo tanto el map completa su ejecucion y retorna un arreglo.
  - Por ultimo se ejecuta puts del arreglo mapeado y retorna nil.

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

begin
    # Luego se almacenan los números
    numeros = 1.upto(cantidad).map do
        puts 'Ingrese un número'
        numero = gets.to_i
    end

    # Y finalmente se imprime cada número dividido por su número entero inmediato anterior
    resultado = numeros.map { | x| x / (x - 1) }
    puts 'El resultado es: %s' % resultado.join(', ')
rescue ZeroDivisionError
    puts '"1" no es un numero valido'
    retry
end
```

--------------------------------------------------------------------------------

### Ejercicio 7.

Partiendo del script del inciso anterior, implementá una nueva clase de excepción que se utilizará para indicar que la entrada del usuario no es un valor numérico entero válido. ¿De qué clase de la jerarquía de Exception heredaría?

Heredaria de RangeError (o ArgumentError?)

```ruby
class IngresoUnoError < RangeError
  def message
    "El numero 1 no es un numero valido. Intente devuelta"
  end
end

cantidad = 0
while cantidad < 15
    puts '¿Cuál es la cantidad de números que ingresará? Debe ser al menos 15'
    cantidad = gets.to_i
end

# Luego se almacenan los números
numeros = 1.upto(cantidad).map do
    begin
        puts 'Ingrese un número'
        numero = gets.to_i
        raise IngresoUnoError if numero == 1
        return numero
    rescue IngresoUnoError => e
        puts e.message
        retry
    end
end

# Y finalmente se imprime cada número dividido por su número entero inmediato anterior
resultado = numeros.map { | x| x / (x - 1) }
puts 'El resultado es: %s' % resultado.join(', ')
```

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

```
Entrando a fun1:
    Se llama a fun1 con parametro x = 0

Entrando a fun2:
    fun1 llama a fun2 con parametro x = 0

Entrando a fun3:
    fun2 llama a fun3

Tratando excepción provocada en tiempo de ejecución:
    fun3 lanza una excepcion de tipo RuntimeError, se rescata y imprime el texto.

Ejecutando ensure de fun3:
    Cuando termina el bloque del rescue o begin (en este caso rescue) siempre se intenta ejecutar el ensure.

Manejador de excepciones de fun1:
    Termina la ejecucion de fun3, fun2 intenta hacer 5/0 lo cual lanza una excepcion.
    Como fun2 no tiene manejador de funcion la atrapa el manejador de fun1.

Ejecutando ensure de fun1:
    Cuando termina el rescue de fun1 se ejecuta el ensure.

Manejador de excepciones de Main:
    Como ensure el manejador de fun1 relanzo la excepcion, la atrapa el manejador de main.

Corrección de x:
    Se ejecuta el manejador de main.
    Se vuelve a ejecutar el bloque begin del main con el nuevo valor de x.

Entrando a fun1:
    blabla.

Entrando a fun2:
    blabla.

Entrando a fun3:
    blabla.

Tratando excepción provocada en tiempo de ejecución:
    fun3 lanza su excepcion nuevamente.

Ejecutando ensure de fun3:
    Se ejecuta el ensure de fun3 luego del rescue.

Terminando fun2:
    fun2 termina su ejecucion correctamente.

Ejecutando ensure de fun1:
    Luego del bloque begin se ejecuta el bloque ensure de fun1.

Salida:
    Termina la ejecucion del main.
```

--------------------------------------------------------------------------------

## Testing

_Nota: Para esta práctica utilizaremos MiniTest en cualquiera de sus variantes (minitest/unit o minitest/spec)._

--------------------------------------------------------------------------------

### Ejercicio 1.

¿En qué consiste la metodología TDD? ¿En qué se diferencia con la forma tradicional de escribir código y luego realizar los tests?

- [By PedroBrost](https://github.com/pedrobrost/Informatica-UNLP/blob/master/Ruby/practica3/practica3.md#1-en-qué-consiste-la-metodología-tdd-en-qué-se-diferencia-con-la-forma-tradicional-de-escribir-código-y-luego-realizar-los-tests)

Desarrollo guiado por pruebas de software, o Test-driven development (TDD) es una práctica de ingeniería de software que involucra otras dos prácticas: Escribir las pruebas primero (Test First Development) y Refactorización (Refactoring). Para escribir las pruebas generalmente se utilizan las pruebas unitarias (unit test en inglés). En primer lugar, se escribe una prueba y se verifica que las pruebas fallan. A continuación, se implementa el código que hace que la prueba pase satisfactoriamente y seguidamente se refactoriza el código escrito. El propósito del desarrollo guiado por pruebas es lograr un código limpio que funcione. La idea es que los requisitos sean traducidos a pruebas, de este modo, cuando las pruebas pasen se garantizará que el software cumple con los requisitos que se han establecido.

Para que funcione el desarrollo guiado por pruebas, el sistema que se programa tiene que ser lo suficientemente flexible como para permitir que sea probado automáticamente. Cada prueba será suficientemente pequeña como para que permita determinar unívocamente si el código probado pasa o no la verificación que ésta le impone. El diseño se ve favorecido ya que se evita el indeseado "sobre diseño" de las aplicaciones y se logran interfaces más claras y un código más cohesivo. Frameworks como JUnit proveen de un mecanismo para manejar y ejecutar conjuntos de pruebas automatizadas.

--------------------------------------------------------------------------------

### Ejercicio 2.

Dado los siguientes tests, escribí el método correspondiente (el que se invoca en cada uno) para hacer que pasen:

```ruby
require 'minitest/autorun'
require 'minitest/spec'

describe '#incrementar' do
    describe 'cuando el valor es numérico' do
        it 'incrementa el valor en un delta recibido por parámetro' do
            x = -9
            delta = 10
            assert_equal(1, incrementar(x, delta))
        end

        it 'incrementa el valor en un delta de 1 unidad por defecto' do
            x = 10
            assert_equal(11, incrementar(x))
        end
    end

    describe 'cuando el valor es un string' do
        it 'arroja un RuntimeError' do
            x = '10'
            assert_raises(RuntimeError) do
                incrementar(x)
            end
            assert_raises(RuntimeError) do
                incrementar(x, 9)
            end
        end
    end
end

describe '#concatenar' do
    it 'concatena todos los parámetros que recibe en un string, separando por espacios' do
        class Dummies ; end
        assert_equal('Lorem ipsum 4 Dummies', concatenar('Lorem', :ipsum, 4, Dummies))
    end
    it 'Elimina dobles espacios si los hubiera en la salida final' do
        assert_equal('TTPS Ruby', concatenar('TTPS', nil, ' ', "\t", "\n", 'Ruby'))
    end
end
```

--------------------------------------------------------------------------------

### Ejercicio 3.

Implementá al menos 3 tests para cada uno de los siguientes ejercicios de las prácticas anteriores:

1. De la práctica 1: 4 (en_palabras), 5 (contar), 6 (contar_palabras) y 9 (longitud).
2. De la práctica 2: 1 (ordenar_arreglo), 2 (ordenar), 4 (longitud), 14 (opposite) y 16 (da_nil?).

--------------------------------------------------------------------------------

### Ejercicio 4.

Implementá los tests que consideres necesarios para probar el Mixin Countable que desarrollaste en el ejercicio 11 de la práctica 2, sin dejar de cubrir los siguientes puntos:

- Testear en una clase existente
- Testear en una clase creada únicamente con el propósito de testear
- Testear qué ocurre antes de que se invoque el método del que se está contando las invocaciones
- Testear la inicialización correcta del Mixin
- Testear algún caso extremo que se te ocurra

--------------------------------------------------------------------------------

### Ejercicio 5.

Suponé que tenés que desarrollar una función llamada 'expansor' la cual recibe un string (conformado únicamente con letras) y devuelve otro string donde cada letra aparezca tantas veces según su lugar en el abecedario. Un ejemplo simple sería:

```ruby
expansor 'abcd'
# => 'abbcccdddd'
```

```ruby
require 'minitest/autorun'
require 'minitest/spec'

describe 'expansor' do
    # Casos de prueba con situaciones y/o entradas de datos esperadas
    describe 'Casos felices' do
        describe 'cuando la entrada es el string "a"' do
            it 'debe devolver "a"'
        end

        describe 'cuando la entrada es el string "f"' do
            it 'debe devolver "ffffff"'
        end

        describe 'cuando la entrada es el string "escoba"' do
            it 'debe devolver "eeeeessssssssssssssssssscccooooooooooooooobba"'
        end
    end

    # Casos de pruebas sobre situaciones inesperadas y/o entradas de datos anómalas
    describe 'Casos tristes' do
        describe 'cuando la entrada no es un string' do
            it 'debe disparar una excepción estándar con el mensaje "La entrada no es un string"'
        end

        describe 'cuando la entrada es el string vacío' do
            it 'debe disparar una excepción estándar con el mensaje "El string es vacío"'
        end

        describe 'cuando la entrada es el string "9"' do
            it 'debe disparar un excepción estándar con el mensaje "El formato del string es incorrecto"'
        end

        describe 'cuando la entrada es el string "*"' do
            it 'debe disparar una excepción estándar con el mensaje "El formato del string es incorrecto"'
        end
    end
end
```

1. Completar la especificación de los casos de prueba.
2. Implementar la función expansor y verificar que todos los casos pasen.
