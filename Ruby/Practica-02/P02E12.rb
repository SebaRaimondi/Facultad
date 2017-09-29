class GenericFactory
    def self.create (**args)
        new(**args)
    end
    def initialize (**args)
        raise NotImplementedError
    end
end

class Concreta < GenericFactory
    def hi
        p "Hi!"
    end
    def initialize(*args)
        @var = true
    end
end