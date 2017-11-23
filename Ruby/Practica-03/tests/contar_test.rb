require 'minitest/autorun'
require 'minitest/spec'

require_relative '../../Practica-01/P01E05.rb'

describe '#contar' do
    describe 'cuando ambos valores ingresados son string' do
        it 'devuelve la cantidad de veces que el segundo string se encuentra en el primero' do
            contar('Lorem ipsum 4 Dummies', 'm').must_equal 4
        end
    end
    describe 'cuando alguno de los parametros no es un string' do
        it 'lanza un NoMethodError' do
            num = 10
            str = 'abc'
            assert_raises(NoMethodError) do
                contar(num, str)
            end
            assert_raises(NoMethodError) do
                contar(str, num)
            end
            assert_raises(NoMethodError) do
                contar(num, num)
            end
        end
    end
end
