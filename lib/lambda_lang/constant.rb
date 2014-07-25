module LambdaLang
  class Constant
    def initialize(value)
      @value = value
    end

    attr_reader :value
  end
end
