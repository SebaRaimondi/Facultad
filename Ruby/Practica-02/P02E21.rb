class Array
	def randomly
		return self.shuffle.map { |x| yield x }
	rescue LocalJumpError => e
		return self.each
	end
end
