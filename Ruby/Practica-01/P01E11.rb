#	11. Escribí una función llamada rot13 que encripte un string recibido como parámetro
#	utilizando el algoritmo ROT13 (https://es.wikipedia.org/wiki/ROT13) . Por ejemplo:

#	rot13("¡Bienvenidos a la cursada 2015 de TTPS Opción Ruby!")
#	# => "¡Ovrairavqbf n yn phefnqn 2015 qr GGCF Bcpvóa Ehol!"

#	def rot13(str)
#		13.times { str.gsub!(/[A-Za-z]/) { |c| c.succ } }
#		return str
#	end

#	print rot13("¡Bienvenidos a la cursada 2015 de TTPS Opción Ruby!")

#	=> "¡Ovraaiiraavqbbff n yn phheeffnqn 2015 qr GGGGCCFF BBccpvóaa EEhholl!"

#	Version 2

def nextChar(n, char)
  n > 0 ? nextChar((n - 1), char.next) : char
end

def rot13(str)
  str.gsub(/[A-Za-z]/) { |c| nextChar(13, c)[-1] }
end

p rot13('¡Bienvenidos a la cursada 2015 de TTPS Opción Ruby!')
