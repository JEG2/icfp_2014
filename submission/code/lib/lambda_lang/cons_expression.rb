module LambdaLang
  class ConsExpression
    def initialize(car, cdr)
      @car = car
      @cdr = cdr
    end

    attr_reader :car, :cdr
  end
end
