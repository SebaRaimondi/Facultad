module GenericFactory
  module ClassMethods
    def create(**args)
      new(**args)
    end
  end

  def initialize(**_args)
    raise NotImplementedError
  end

  def self.included(base)
    base.extend(ClassMethods)
  end
end

class Concreta
  extend GenericFactory

  def hi
    p 'Hi!'
  end

  def initialize(*_args)
    @var = true
  end
end

# Cambie self.create a create.
