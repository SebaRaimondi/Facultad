#	17. Cada nuevo término en la secuencia de Fibonacci es generado sumando los 2 términos
#	anteriores. Los primeros 10 términos son: 1, 1, 2, 3, 5, 8, 13, 21, 34, 55. Considerando los
#	términos en la secuencia de Fibonacci cuyos valores no exceden los 4 millones,
#	encontrá la suma de los términos pares.

#	def sumOddFib(max = 4000000)
#		pre = [1]		# Array, contains the 2 previous terms.
#		count = 1		# Int, counts terms processed.
#		cur = 1			# Has current term.
#		sum = 0
#		while (1..max).include?(cur)
#			pre[count % 2] = cur
#			if (cur % 2 == 0)
#				sum += cur
#			end
#			cur = pre.sum
#			count += 1
#		end
#		return sum
#	end

#	p sumOddFib(4000000)

#	Version 2

#	def fib(prev1, prev2, sum, max)
#		curr = prev1 + prev2
#		return sum if curr > max
#		sum += curr if curr % 2 == 0
#		fib(prev2, curr, sum, max)
#	end

#	def sumFairFib2(max)
#		fib(1, 1, 0, max)
#	end

def fibSetup(max)
  fib =
    Enumerator.new do |y|
      a = b = 1

      loop do
        y << a
        a, b = b, a + b
      end
    end
  fib.lazy.select(&:even?).take_while { |val| val < max }.sum
end

p fibSetup(4_000_000)
