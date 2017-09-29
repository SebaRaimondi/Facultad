#	12. Escribí una función más genérica, parecida a la del ejercicio anterior, que reciba como
#	parámetro un string y un número n, y que realice una rotación de n lugares de las letras
#	del string y retorne el resultado. Por ejemplo:

#	rot("¡Bienvenidos a la cursada 2015 de TTPS Opción Ruby!", 13)
#	# => "¡Ovrairavqbf n yn phefnqn 2015 qr GGCF Bcpvóa Ehol!"

#	def rot(str, i = 1)
#		i.times { str.gsub!(/[A-Za-z]/) { |c| c.succ } }
#	return str
#	end

#	rot("¡Bienvenidos a la cursada 2015 de TTPS Opción Ruby!", 13)

#	Preguntar, mismo problema que E11

def nextChar(n, char)
  n > 0 ? nextChar((n - 1), char.next) : char
end

def rot(str, i = 1)
  str.gsub(/[A-Za-z]/) { |c| nextChar(i, c)[-1] }
end

p rot('¡Bienvenidos a la cursada 2015 de TTPS Opción Ruby!', 13)
