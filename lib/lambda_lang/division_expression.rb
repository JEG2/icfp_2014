module LambdaLang
  class DivisionExpression
    def initialize(left, right)
      @left  = left
      @right = right
    end

    attr_reader :left, :right
  end
end