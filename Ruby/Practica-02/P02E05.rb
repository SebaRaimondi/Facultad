# 5. Implementá el método cuanto_falta? que opcionalmente reciba como parámetro un objeto Time y que calcule la cantidad de minutos que faltan para ese momento. Si el parámetro de fecha no es provisto, asumí que la consulta es para la medianoche de hoy.
# Por ejemplo:

def cuanto_falta?(time = Time.new(Time.new.year, Time.new.month, Time.new.day + 1) - 1)
  time - Time.now
end

p cuanto_falta? Time.new(2017, 12, 31, 23, 59, 59)
# Debe retornar la cantidad de minutos que faltan para las 23:59:59 del 31/12/2017
p cuanto_falta?
# Debe retornar la cantidad de minutos que faltan para la medianoche de hoy
