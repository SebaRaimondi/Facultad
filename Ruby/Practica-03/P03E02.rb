def incrementar(val, delta = 1)
    raise 'Valor no numerico' if val.is_a? String
    val + delta
end

def concatenar(*args)
    args.join(' ').split.join(' ')
end
