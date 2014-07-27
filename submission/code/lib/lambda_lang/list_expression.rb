module LambdaLang
  class ListExpression
    def initialize(elements)
      @elements = elements
    end

    attr_reader :elements
  end
end
