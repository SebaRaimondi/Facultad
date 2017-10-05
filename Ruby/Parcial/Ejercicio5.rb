require_relative 'my_random.rb'
require_relative 'moderator.rb'

class Bingo
    attr_accessor   :moderador, :randomizer
    def initialize
        self.moderador = Object.new.extend(Moderator)
        self.randomizer = MyRandom.new 99
    end

    def line?(num)
        return true if @line
        if @line = moderador.line?(num)
            puts "Hubo linea!"
        end
        return @line
    end

    def bingo?(num)
        return true if @bingo
        if @bingo = moderador.bingo?(num)
            puts "Salio Bingo!"
        end
        return @bingo
    end

    def play
        fin = false
        until fin
            begin
                num = randomizer.next
            rescue => e
                puts "#{e.message}"
                break
            end
            puts "Salio el numero #{num}"
            fin = line?(num) && bingo?(num)
        end
        puts "Fin del juego"
    end
end

# Ejemplo de uso:
# bingo = Bingo.new
# bingo.play