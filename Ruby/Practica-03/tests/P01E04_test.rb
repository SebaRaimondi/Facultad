require 'minitest/autorun'
require 'minitest/spec'

describe '#en_palabras' do
    describe 'cuando 0 <= minutos <= 10' do
        it 'devuelve en punto' do
            en_palabras(Time.new(2002, 10, 31, 2, 2, 2)).must_equal 'Son las 2 en punto'
        end
    end
    describe 'cuando 11 <= minutos <= 20' do
        it 'devuelve y cuarto' do
            en_palabras(Time.new(2002, 10, 31, 2, 15, 2)).must_equal 'Son las 8 y cuarto'
        end
    end
    describe 'cuando 21 <= minutos <= 34' do
        it 'devuelve y media' do
            en_palabras(Time.new(2002, 10, 31, 2, 30, 2)).must_equal 'Son las 8 y media'
        end
    end
    describe 'cuando 35 <= minutos <= 44' do
        it 'devuelve menos veinticinco' do
            en_palabras(Time.new(2002, 10, 31, 2, 37, 2)).must_equal 'Son las 8 menos veinticinco'
        end
    end
    describe 'cuando 45 <= minutos <= 55' do
        it 'devuelve menos cuarto' do
            en_palabras(Time.new(2002, 10, 31, 2, 48, 2)).must_equal 'Son las 8 menos cuarto'
        end
    end
    describe 'cuando 56 <= minutos <= 59' do
        it 'devuelve casi la hora siguiente' do
            en_palabras(Time.new(2002, 10, 31, 2, 58, 2)).must_equal 'Son casi las 3'
        end
    end
end
