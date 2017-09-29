VALUE = 'global'
module A
	VALUE = 'A'
	class B
		VALUE = 'B'
		def self.value
			VALUE
		end

		def value
			'iB'
		end

	end

	def self.value
		VALUE
	end

end

class C
	class D
		VALUE = 'D'
		def self.value
			VALUE
		end

	end

	module E
		def self.value
			VALUE
		end

	end

	def self.value
		VALUE
	end

end

class F < C
	VALUE = 'F'
end

p "1. ¿Qué imprimen cada una de las siguientes sentencias? ¿De dónde está obteniendo
el valor?"
p "1. puts A.value --> #{A.value}"
p "2. puts A::B.value --> #{A::B.value}"
p "3. puts C::D.value --> #{C::D.value}"
p "4. puts C::E.value --> #{C::E.value}"
p "5. puts F.value --> #{F.value}"

p "2. ¿Qué pasaría si ejecutases las siguientes sentencias? ¿Por qué?"
p "1. puts A::value --> #{A::value}"
p "2. puts A.new.value --> undefined method `new' for A:Module"
p "3. puts B.value --> uninitialized constant B"
p "4. puts C::D.value --> #{C::D.value}"
p "5. puts C.value --> #{C.value}"
p "6. puts F.superclass.value --> #{F.superclass.value}"

# Paja