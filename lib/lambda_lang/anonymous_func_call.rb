module LambdaLang
  class AnonymousFuncCall
    def initialize(name, arguments)
      @name      = name
      @arguments = arguments
    end

    attr_reader :name, :arguments
  end
end
