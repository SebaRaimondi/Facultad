#	2. Modificá el método anterior para que en lugar de recibir un arreglo como único parámetro, reciba todos los números como parámetros separados. Por ejemplo:

def ordenar(*params)
  params.sort
end

p ordenar(1, 4, 6, 2, 3, 5, 0, 10, 9)
# => [0, 1, 2, 4, 5, 6, 9, 10]
