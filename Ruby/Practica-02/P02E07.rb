# 7. Modificá el código anterior para, acorde a tu análisis, corregir los problemas que pueda tener.
# Nota: asumí que el juego debe terminar al momento que el primer jugador supera la posición 40 en el tablero.

def tirar_dado
  rand 1..6
end
players = Enumerator.new do |caller|
  loop do
    %i[azul rojo verde].shuffle.each { |p| caller << p }
  end
end

game = Enumerator.new do |caller|
  # Necesito que player no sea local al loop
  player = nil
  board = { azul: 0, rojo: 0, verde: 0 }
  loop do
    player = players.next
    board[player] += tirar_dado
    break if board[player] > 40
    puts "#{player} ahora está en el casillero #{board[player]}"
    caller << false
  end

  puts "Ganó #{player}!!"
  caller << true
end

fin = false
fin = game.next until fin
