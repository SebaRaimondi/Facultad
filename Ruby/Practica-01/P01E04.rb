#	4. Escribí una función que convierta a palabras la hora actual, dividiendo en los siguientes
#		rangos los minutos:

#		Si el minuto está entre 0 y 10, debe decir "en punto",
#		si el minuto está entre 11 y 20, debe decir "y cuarto",
#		si el minuto está entre 21 y 34, debe decir "y media",
#		si el minuto está entre 35 y 44, debe decir "menos veinticinco" (de la hora
#			siguiente),
#		si el minuto está entre 45 y 55, debe decir "menos cuarto" (de la hora siguiente),
#		y si el minuto está entre 56 y 59, debe decir "casi las" (y la hora siguiente)

def en_palabras(time)
    hour = (0..34) === time.min ? time.hour : (time + 60 * 60).hour
    min =
        case time.min
        when 0..10  then 'en punto'
        when 11..20 then 'y cuarto'
        when 21..34 then 'y media'
        when 35..44 then 'menos veinticinco'
        when 45..55 then 'menos cuarto'
        when 56..59 then return "Son casi las #{hour}"
        end
    "Son las #{hour} #{min}"
end

p en_palabras(Time.now)
