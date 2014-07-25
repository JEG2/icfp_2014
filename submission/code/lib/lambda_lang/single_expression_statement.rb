module LambdaLang
  class SingleExpressionStatement
    def initialize(expression)
      @expression = expression
    end

    attr_reader :expression
  end
end
