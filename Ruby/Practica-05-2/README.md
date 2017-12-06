# Practica 5

## Comandos utilizados:

### Ejercicio 3

Siguiendo los pasos que enumeraste en el punto anterior, creá una nueva aplicación Rails llamada practica_cinco en la cual vas a realizar las pruebas para los ejercicios de esta práctica.

`rails new practica_cinco`

--------------------------------------------------------------------------------

### Ejercicio 5

#### Inciso 3

Sobre la configuración de Rails:

Modificá el locale por defecto de tu aplicación para que sea español

Instalar la gema `rails-i18n` y agregar la siguiente linea a config/application.rb:

`config.i18n.default_locale = :'es-AR'`

#### Inciso 4

Modificá la zona horaria de tu aplicación para que sea la de la Argentina

Agregar la siguiente linea a config/application.rb

`config.time_zone = 'Buenos Aires'`

--------------------------------------------------------------------------------

### Ejercicio 6

#### Inciso 4

Creá un initializer en tu aplicación que imprima en pantalla el string "Booting practica_cinco".

Creado archivo `config/initializers/booting.rb`

--------------------------------------------------------------------------------

### Ejercicio 7

#### Inciso 2

¿Con qué comando podés consultar todos los generators disponibles en tu app Rails?

`rails generate` desde el root del proyecto

#### Inciso 3

Utilizando el generator adecuado, creá un controller llamado PoliteController que tenga una acción salute que responda con un saludo aleatorio de entre un arreglo de 5 diferentes, como por ejemplo "Good day sir/ma'am.".

`rails generate controller Polite`
