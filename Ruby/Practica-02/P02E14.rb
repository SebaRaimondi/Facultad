module Opposite
	def opposite
		!self
	end
end

true.class.extend Opposite
false.class.extend Opposite

p "true.opposite --> #{true.opposite}"
p "false.opposite --> #{false.opposite}"
