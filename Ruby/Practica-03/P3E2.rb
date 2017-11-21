# describe '#incrementar' do
#     describe 'cuando el valor es numérico' do
#         it 'incrementa el valor en un delta recibido por parámetro' do
#             x = -9
#             delta = 10
#             assert_equal(1, incrementar(x, delta))
#         end

#         it 'incrementa el valor en un delta de 1 unidad por defecto' do
#             x = 10
#             assert_equal(11, incrementar(x))
#         end
#     end

#     describe 'cuando el valor es un string' do
#         it 'arroja un RuntimeError' do
#             x = '10'
#             assert_raises(RuntimeError) do
#                 incrementar(x)
#             end
#             assert_raises(RuntimeError) do
#                 incrementar(x, 9)
#             end
#         end
#     end
# end

# describe '#concatenar' do
#     it 'concatena todos los parámetros que recibe en un string, separando por espacios' do
#         class Dummies ; end
#         assert_equal('Lorem ipsum 4 Dummies', concatenar('Lorem', :ipsum, 4, Dummies))
#     end
#     it 'Elimina dobles espacios si los hubiera en la salida final' do
#         assert_equal('TTPS Ruby', concatenar('TTPS', nil, ' ', "\t", "\n", 'Ruby'))
#     end
# end

def incrementar(val, delta = 1)
    raise 'Valor no numerico' if val.is_a? String
    val + delta
end

def concatenar(*args)
    args.join(' ').split.join(' ')
end
