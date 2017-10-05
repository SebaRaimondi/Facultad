# my_random.rb
class MyRandom
    attr_accessor :maximum, :available, :taken
  
    def initialize(maximum)
      self.maximum = maximum
      self.available = (0..maximum).to_a
      self.taken = []
    end
  
    def next
      raise 'Se agotaron los números posibles' if available.empty?
      value = self.available.shuffle!.shift
      self.taken << value
      value
    end
  end
  
  # Ejemplo de uso:
  #
  # r = MyRandom.new(5) # Generador de valores aleatorios entre 0 y 5
  # r.next
  # #=> 1
  # r.next
  # #=> 5
  # r.next
  # #=> 2
  # r.next
  # #=> 3
  # r.next
  # #=> 0
  # r.next
  # #=> 4
  # r.next
  # #=> RuntimeError: Se agotaron los números posibles
  