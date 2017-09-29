# 4. Escribí un método que dado un número variable de parámetros que pueden ser de cualquier tipo, imprima en pantalla la cantidad de caracteres que tiene su representación como String y la representación que se utilizó para contarla.
# Nota: Para convertir cada parámetro a string utilizá el método #to_s presente en todos los objetos.
# Por ejemplo:

def longitud(*params)
  params.each { |a| p "#{a} --> #{a.to_s.size}" }
end

p longitud(9, Time.now, 'Hola', { un: 'hash' }, :ruby)
# Debe imprimir:
# "9" --> 1
# "2017-09-14 13:22:10 +0000" --> 25
# "Hola" --> 4
# {:un=>"hash"} --> 13
# ruby --> 4
