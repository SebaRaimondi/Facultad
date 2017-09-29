def prueba(*args)
	begin
		yield args
	rescue RuntimeError
		puts "Algo salio mal"
		return :rt
	rescue NoMethodError => b
		puts "No encontre un metodo: " << b.message
		return :nm
	rescue
		puts "No se que hacer!"
		raise
	else
		return :ok
end

p prueba("a", "b", "c") { x.to_s.upcase }
