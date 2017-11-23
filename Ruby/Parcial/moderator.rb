# moderator.rb
module Moderator
  def line?(number)
    # Simulación
    @line_queries ||= 0
    @line_queries += 1
    @line_queries > 25 || @line_queries > 8 && rand(0..99) == number
  end

  def bingo?(number)
    # Simulación
    @bingo_queries ||= 0
    @bingo_queries += 1
    @bingo_queries > 40 && rand(0..99) == number
  end
  end
