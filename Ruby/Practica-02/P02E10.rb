module Reverso
    def di_tcejbo
        self.object_id.to_s.reverse
    end
    def ssalc
        self.class.to_s.reverse
    end
end

class Prueba
    include Reverso
end

prueba = Prueba.new
p "Metodo di_tcejbo --> #{prueba.di_tcejbo}"
p "Metodo ssalc --> #{prueba.ssalc}"
