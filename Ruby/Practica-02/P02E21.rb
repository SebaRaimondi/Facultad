class Array
  def randomly
    return shuffle.map { |x| yield x }
  rescue LocalJumpError
    return each
  end
end
