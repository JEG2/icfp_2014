module LambdaLang
  class Literal
    def initialize(value)
      @value = value
    end

    attr_reader :value
  end
end
