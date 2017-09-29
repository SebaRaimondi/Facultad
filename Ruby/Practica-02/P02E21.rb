class Array
  def randomly
    return shuffle.map { |x| yield x }
  rescue LocalJumpError => e
    return each
  end
end
