module Countable
    # Para no tener que sobreescribir initialize
    def invocations
        # ||= devuelve invocations o le asigna y devuelve Hash.new(0)
        # La primera vez devuelve y asigna Hash.new(0), todas las siguientes veces devuelve la var
        @invocations ||= Hash.new(0)
    end

    module ClassMethods
        # Los siguientes metodos se incluiran como metodos de clase.
        def count_invocations_of(sym)
            # Creo una copia del metodo recibido como parametro. Su nombre sera el mismo con "o_" al principio.
            # Con esto puedo modificar el metodo original sin perder su funcionamiento.
            # El funcionamiento original queda en la copia que empieza con "o_".
            alias_method(:"o_#{sym}", sym)
 
            # Sobreescribo el original.
            define_method "#{sym}" do
                # Aumento la cantidad de veces que se llamo el metodo.
                # __method__ contiene el nombre del metodo en el que se ejecuta.
                invocations[__method__] += 1
                
                # Ejecuto la funcionalidad original del metodo.
                send(:"o_#{__method__}")
            end
        end
    end

    # Este metodo se ejecuta cuando se incluye el modulo.
    def self.included(base)
        # Extiendo la clase con los metodos del modulo ClassMethods.
        # Los metodos definidos en ClassMethods seran metodos de clase en la clase que lo incluye.
        base.extend(ClassMethods)
    end

    # Devuelve true si fue llamado.
    def invoked?(sym)
        invocations[sym] > 0
    end

    # Devuelve la cantidad de veces que el metodo fue llamado.
    def invoked(sym)
        invocations[sym]
    end
end


class Greeter
    # Incluyo el Mixin
    include Countable
    def hi
        puts 'Hey!'
    end
    def bye
        puts 'See you!'
    end
    # Indico que quiero llevar la cuenta de veces que se invoca el método #hi
    count_invocations_of :hi
end
