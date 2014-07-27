module LambdaLang
  class FuncDefinition
    def initialize(name, parameters, statements)
      @name       = name
      @parameters = parameters
      @statements = statements
    end

    attr_reader :name, :parameters, :statements
  end
end
