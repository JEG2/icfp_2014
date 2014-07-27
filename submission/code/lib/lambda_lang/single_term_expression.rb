module LambdaLang
  class SingleTermExpression
    def initialize(term)
      @term = term
    end

    attr_reader :term
  end
end
