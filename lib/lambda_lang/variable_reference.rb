module LambdaLang
  class VariableReference
    def initialize(name)
      @name = name
    end

    attr_reader :name
  end
end
