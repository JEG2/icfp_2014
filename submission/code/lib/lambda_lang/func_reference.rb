module LambdaLang
  class FuncReference
    def initialize(name)
      @name = name
    end

    attr_reader :name
  end
end
