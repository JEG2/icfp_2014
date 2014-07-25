require_relative "func_definition"
require_relative "cons_statement"
require_relative "constant"
require_relative "func_reference"
require_relative "literal"

module LambdaLang
  class Parser
    def initialize(lexer)
      @lexer = lexer
    end

    attr_reader :lexer
    private     :lexer

    def parse
      parse_functions
    end

    private

    def parse_functions
      functions = [ ]
      while lexer.next?
        functions << parse_function
      end
      functions
    end

    def parse_function
      fail "func keyword expected" unless lexer.next == "func"

      name       = parse_name rescue fail("function name expected")
      opening    = lexer.next or     fail "function parameters or body expected"
      parameters =
        if opening == "("
          parse_parameters.tap do
            opening = lexer.next
          end
        else
          [ ]
        end

      fail "function body expected" unless opening == "{"
      statements = parse_statements

      FuncDefinition.new(name, parameters, statements)
    end

    def parse_name
      name = lexer.next
      fail "name expected" unless name =~ /\A\w+\z/
      name
    end

    def parse_parameters
      parameters = [ ]
      loop do
        token = lexer.next
        break if token == ")"

        fail "name expected" unless token =~ /\A\w+\z/
        parameters << token

        case lexer.peek
        when ","
          lexer.next
        when ")"
          # do nothing:  we'll break after the loop
        else
          fail "malformed parameters"
        end
      end
      parameters
    end

    def parse_statements
      statements = [ ]
      loop do
        token = lexer.next
        break if token == "}"

        statements <<
          case token
          when "{"
            parse_cons_statement
          else
            fail "unknown statement type"
          end
      end
      statements
    end

    def parse_cons_statement
      car = parse_term
      fail "malformed cons statement" unless lexer.next == ","
      cdr = parse_term
      fail "expected cons statement end" unless lexer.next == "}"

      ConsStatement.new(car, cdr)
    end

    def parse_term
      token = lexer.next
      case token
      when /\A\d+\z/
        Literal.new(token)
      when /\A[A-Z]+\z/
        Constant.new(token)
      when "&"
        FuncReference.new(parse_name)
      else
        fail "unknown term"
      end
    end
  end
end
