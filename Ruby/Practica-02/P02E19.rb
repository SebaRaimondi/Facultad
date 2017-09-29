fib =
  Enumerator.new do |y|
    a = b = 1

    loop do
      y << a
      a, b = b, a + b
    end
  end
