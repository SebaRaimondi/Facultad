require_relative 'my_random.rb'
require_relative 'moderator.rb'

class Bingo
  attr_accessor :moderador, :randomizer
  def initialize
    self.moderador = Object.new.extend(Moderator)
    self.randomizer = MyRandom.new 99
  end

  def line?(num)
    return true if @line
    puts 'Hubo linea!' if @line = moderador.line?(num)
    @line
  end

  def bingo?(num)
    return true if @bingo
    puts 'Salio Bingo!' if @bingo = moderador.bingo?(num)
    @bingo
  end

  def play
    loop do
      begin
        num = randomizer.next
      rescue => e
        puts e.message.to_s
        break
      end
      puts "Salio el numero #{num}"
      break if line?(num) && bingo?(num)
    end
    puts 'Fin del juego'
  end
end

# Ejemplo de uso:
# bingo = Bingo.new
# bingo.play
