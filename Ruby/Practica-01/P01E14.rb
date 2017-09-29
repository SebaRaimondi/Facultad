#	14. Dado un color expresado en notación RGB (https://es.wikipedia.org/wiki/RGB) , debés calcular
#	su representación entera y hexadecimal, donde la notación entera se define como red +
#	green*256 + blue*256*256 y la hexadecimal como el resultado de expresar en
#	hexadecimal el valor de cada color y concatenarlos en orden. Por ejemplo:

#	notacion_hexadecimal([0, 128, 255])
#	# => '#0080FF'
#	notacion_entera([0, 128, 255])
#	# => 16744448

def notacion_hexadecimal(arr)
  arr.inject('#') { |sum, value| sum << value.to_s(16).rjust(2, '0').upcase }
end

def notacion_entera(arr)
  arr.each.with_index.inject(0) { |sum, (value, index)| sum + value * (256**index) }
end

p notacion_hexadecimal([0, 128, 255])
# => '#0080FF'
p notacion_entera([0, 128, 255])
# => 16744448
