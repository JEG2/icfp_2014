module LambdaLang
  class IfStatement
    def initialize(conditional, true_statements, false_statements)
      @conditional      = conditional
      @true_statements  = true_statements
      @false_statements = false_statements
    end

    attr_reader :conditional, :true_statements, :false_statements
  end
end
