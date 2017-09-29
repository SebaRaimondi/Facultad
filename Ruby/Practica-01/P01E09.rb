#	9. Escribí una función que dado un arreglo que contenga varios string cualesquiera,
#	retorne un nuevo arreglo donde cada elemento es la longitud del string que se
#	encuentra en la misma posición del arreglo recibido como parámetro. Por ejemplo:

#	longitud(['TTPS', 'Opción', 'Ruby', 'Cursada 2015'])
#	# => [4, 6, 4, 12]

def longitud(array)
  array.map(&:size)
end

p longitud(['TTPS', 'Opción', 'Ruby', 'Cursada 2015'])
