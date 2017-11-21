module Countable
  def invocations
    @invocations ||= Hash.new(0)
  end

  module ClassMethods
    def count_invocations_of(sym)
      alias_method(:"o_#{sym}", sym)

      define_method sym.to_s do
        invocations[__method__] += 1
        send(:"o_#{__method__}")
      end
    end
  end

  def self.included(base)
    base.extend(ClassMethods)
  end

  def invoked?(sym)
    invocations[sym] > 0
  end

  def invoked(sym)
    invocations[sym]
  end
end
