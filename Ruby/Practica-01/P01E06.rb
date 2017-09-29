#	6. Modificá la función anterior para que sólo considere como aparición del segundo string
#	cuando se trate de palabras completas. Por ejemplo:

#	contar_palabras("La casa de la esquina tiene la puerta roja y la ventana blan
#	ca.", "la")
#	# => 4

def contar(str1, str2)
  str1.downcase.scan(str2.downcase).split.count { |x| x == 'la' }
end

p contar('La casa de la esquina tiene la puerta roja y la ventana blanca.', 'la')
