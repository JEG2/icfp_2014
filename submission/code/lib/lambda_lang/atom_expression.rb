module LambdaLang
  class AtomExpression
    def initialize(value)
      @value = value
    end

    attr_reader :value
  end
end
