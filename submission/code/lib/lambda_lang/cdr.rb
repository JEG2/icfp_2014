module LambdaLang
  class Cdr
    def initialize(cons)
      @cons = cons
    end

    attr_reader :cons
  end
end
