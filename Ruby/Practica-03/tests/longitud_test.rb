require 'minitest/autorun'
require 'minitest/spec'

require_relative '../../Practica-01/P01E09.rb'

describe '#longitud' do
    describe 'Casos felices' do
        describe 'Cuando el parametro es un arreglo de strings' do
            it 'Retorna un array con las longitudes de los strings enviados' do
                longitud(%w[Lorem ipsum 4 Dummies]).must_equal [5, 5, 1, 7]
            end
        end
    end
    describe 'Casos tristes' do
        describe 'Cuando el parametro no es un arreglo' do
            it 'Lanza NoMethodError' do
                assert_raises(NoMethodError) do
                    longitud(1)
                end
            end
        end
    end
end
