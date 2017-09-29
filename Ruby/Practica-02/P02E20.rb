# Solo ejecuta lo que necesita para devolver el resultado.
# Si hago enumerator.collect { |x| x*x }.first(10) en un enumerator infinito, nunca termina la ejecucion
# Si en cambio hago enumerator.lazy.collect { |x| x*x }.first(10), solo ejecuta lo necesario para devolver los primeros 10 resultados.
