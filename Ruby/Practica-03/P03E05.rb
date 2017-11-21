def expansor(str)
    def param?(str)
        raise 'La entrada no es un string' unless str.is_a String
        raise 'El string es vacio' if str == ''
        raise 'El formato del string es incrorecto' unless str !~ /[^a-zA-Z]/i
    end

    # Creo un array con las letras
    arr = ('a'..'z').to_a

    # Creo un hash del estilo {'a' => 1, 'b' => 2, etc}
    x = Hash[(1...arr.size).zip arr].invert

    res = ''
    str.chars.map { |c| x[c.downcase].times { res << c } }
    res
end
