#	8. ¿Qué hace el siguiente código?

%i[upcase downcase capitalize swapcase].map do |meth|
  'TTPS Ruby'.send(meth)
end

# 	Le envia un arreglo de 4 simbolos que coinciden con 4 mensajes que
# 	entienden los string. Luego itera por el arreglo, enviandole cada
#	uno de los mensajes al string "TTPS Ruby", guardando el resultado
#	en un nuevo arreglo.
