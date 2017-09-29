class GenericFactory
  def self.create(**args)
    new(**args)
  end

  def initialize(**_args)
    raise NotImplementedError
  end
end

class Concreta < GenericFactory
  def hi
    p 'Hi!'
  end

  def initialize(*_args)
    @var = true
  end
end
