def procesar_hash hash
	hash.invert.transform_values { | v | yield v }
end


hash = { 'clave' => 1, :otra_clave => 'valor' }
p procesar_hash(hash) { |x| x.to_s.upcase }
# => { 1 => 'CLAVE', 'valor' => 'OTRA_CLAVE' }