# Practica 5

## Rails

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

`rails generate controller Polite salute`, luego modificar el metodo `salute` de app/controllers/polite_controller.rb con la funcionalidad deseada

--------------------------------------------------------------------------------

### Ejercicio 8

1. ¿Dónde se definen las rutas de la app Rails?

  `config/routes.rb` Se chequean ejecutando `bin/rails routes`

2. ¿De qué formas se pueden definir las rutas?

  Terrible magia.

3. ¿Qué ruta(s) agregó el generator que usaste antes?

  `GET /polite/salute(.:format) polite#salute`

4. ¿Con qué comando podés consultar todas las rutas definidas en tu app Rails?

  `bin/rails routes`

--------------------------------------------------------------------------------

## ActiveSupport (AS)

4 ¿De qué manera se le puede enseñar a AS cómo pasar de singular a plural (o viceversa) los sustantivos que usamos en nuestro código? Tip: Mirá el archivo config/initializers/inflections.rb

5 Modificá la configuración de la aplicación Rails para que aprenda a pluralizar correctamente en español todas las palabras que terminen en l, n y r. Tip: el uso de expresiones regulares simples ayuda. :)

4 y 5 los tendria que hacer pero quiero siesta :)

--------------------------------------------------------------------------------

## ActiveRecord (AR)

1. ¿Cómo se define un modelo con ActiveRecord? ¿Qué requisitos tienen que cumplir las clases para utilizar la lógica de abstracción del acceso a la base de datos que esta librería ofrece?

`$ bin/rails generate model Offices name:string phone_number:string, limit: 30 address:text available:boolean null: false`

Esto tambien genera la migracion

Los modelos se crean en `app/models` y las migraciones en `db/migrate`

1. Creá el modelo Office para la tabla offices que creaste antes, e implementale el método `#to_s`.

`bin/rails generate model Office name:string{255} phone_number:string{30} address:text available:boolean`

Luego cambio la linea en la migracion de Offices:

- Antes: `t.boolean :available`
- Despues `t.boolean :available, default: false`

Luego en el archivo del modelo de Offices

1. Utilizando migraciones, creá la tabla y el modelo para la clase Employee, con la siguiente 4 of 5 estructura:

  ```
  name: string de 150 caracteres, no puede ser nulo.
  e_number: integer, no puede ser nulo, debe ser único.
  office_id: integer, foreign key hacia offices.
  ```

`bin/rails generate migration CreateEmployees name:string{150} e_number:integer:uniq office:references`

Agrego `null: false` a las que lo requieran, lo de referencia no lo se bien. Si alguno lo puede hacer genial.

Para generar el modelo `bin/rails g model Employee --skip-migration`

_`bin/rails g` es una abreviacion de `bin/rails generate`_

1. ¿Qué tipo de asociación declaraste en la clase Employee? `belongs_to :office`

2. ¿Y en la clase Office? `has_many :employee`

3. ¿Qué métodos generó AR en el modelo a partir de esto?

  Getters y setters de las referencias?

4. Modificá el mapeo de rutas de tu aplicación Rails para que al acceder a / se vaya al controller definido antes (polite#salute).

  Agregado `root 'polite#salute'` en config/routes.rb

### Scopes

1. ¿Qué son los scopes de AR? ¿Para qué los utilizarías?

  Permiten especificar queries comunmente usados que pueden ser referenciados como llamadas a metodos.

2. Investigá qué diferencia principal existe entre un método estático y un scope.

  Si por metodos estaticos se refieren a metodos de clase, no tienen diferencia.

  ```ruby
  scope :published, -> { where(published: true) }

  def self.published
  where(published: true)
  end
  ```

  son equivalentes

3. Agregá los siguientes scopes al modelo Employee: vacant: Filtra los empleados para quedarse únicamente con aquellos que no tengan una oficina asignada (asociada). occupied: Complemento del anterior, devuelve los empleados que sí tengan una oficina asignada.

  En app/models/employee.rb

  ```ruby
  scope :vacant, -> { where(office: nil) }
  scope :occupied, -> { where.not(office: nil) }
  ```

4. Agregá este scope al modelo Office: empty: Devuelve las oficinas que están disponibles (available = true) que no tienen empleados asignados.

  En app/models/office.rb: `scope :empty, -> { where(available: true) }`

--------------------------------------------------------------------------------

#### Scaffold

1. ¿Qué son? ¿Qué operaciones proveen sobre un modelo?

  La mas magia de las magias de Rails

  A scaffold in Rails is a full set of model, database migration for that model, controller to manipulate it, views to view and manipulate the data, and a test suite for each of the above.

2. ¿Con qué comando se generan? `bin/rails generate scaffold HighScore game:string score:integer`

3. Utilizando el generator anterior, generá un controlador de scaffold para el modelo Office y otro para el modelo Employee.

  ```
  bin/rails generate scaffold Employee --skip
  bin/rails generate scaffold Office --skip
  ```

  `--skip` para que no modifique los archivos model y migration que ya existen.

4. ¿Qué rutas agregó este generator?

  ```
  employees       GET    /employees(.:format)          employees#index
  POST   /employees(.:format)          employees#create
  new_employee    GET    /employees/new(.:format)      employees#new
  edit_employee   GET    /employees/:id/edit(.:format) employees#edit
  employee        GET    /employees/:id(.:format)      employees#show
  PATCH  /employees/:id(.:format)      employees#update
  PUT    /employees/:id(.:format)      employees#update
  DELETE /employees/:id(.:format)      employees#destroy
  offices         GET    /offices(.:format)            offices#index
  POST   /offices(.:format)            offices#create
  new_office      GET    /offices/new(.:format)        offices#new
  edit_office     GET    /offices/:id/edit(.:format)   offices#edit
  office          GET    /offices/:id(.:format)        offices#show
  PATCH  /offices/:id(.:format)        offices#update
  PUT    /offices/:id(.:format)        offices#update
  DELETE /offices/:id(.:format)        offices#destroy
  ```

5. Analizá el código que se te generó para los controllers y para las vistas, y luego modificalo para que no permita el borrado de ninguno de los elementos. ¿Qué cambios debés hacer para que las vistas no muestren la opción, el controller no tenga la acción destroy y las rutas de borrado dejen de existir en la aplicación?

  En las vistas borrar las lineas

  ```ruby
  <td><%= link_to 'Destroy', employee, method: :delete, data: { confirm: 'Are you sure?' } %></td>
  <td><%= link_to 'Destroy', office, method: :delete, data: { confirm: 'Are you sure?' } %></td>
  ```

  En los controller eliminar los metodos `destroy`

  En `config/routes.rb` modificar las lineas:

  ```ruby
  resources :employees
  resources :offices
  ```

  agregandoles `, except: :destroy`:

  ```ruby
  resources :employees, except: :destroy
  resources :offices, except: :destroy
  ```
