#	5. Escribí una función llamada contar que reciba como parámetro dos string y que retorne
#	la cantidad de veces que aparece el segundo string en el primero, sin importar
#	mayúsculas y minúsculas. Por ejemplo:

#	contar("La casa de la esquina tiene la puerta roja y la ventana blanca.", "la
#	")
#	# => 5

def contar(str1, str2)
  str1.downcase.scan(str2.downcase).count
end

p contar('La casa de la esquina tiene la puerta roja y la ventana blanca.', 'la')
