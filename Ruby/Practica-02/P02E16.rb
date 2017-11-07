def da_nil?
    yield.nil?
end

p da_nil? {}
# => true
p da_nil? { 'Algo distinto de nil' }
# => false
