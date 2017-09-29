#	16. Escribí una función que encuentre la suma de todos los números naturales múltiplos de
#	3 ó 5 menores que un número tope que reciba como parámetro.

def sum(max)
  (1..max - 1).select { |x| (x % 3).zero? || (x % 5).zero? }.sum
end

p sum(1000)
