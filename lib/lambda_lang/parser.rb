require_relative "func_definition"

require_relative "if_statement"
require_relative "debug_statement"
require_relative "single_expression_statement"

require_relative "cons_expression"
require_relative "addition_expression"
require_relative "subtraction_expression"
require_relative "multiplication_expression"
require_relative "division_expression"
require_relative "single_term_expression"
require_relative "equals_expression"
require_relative "greater_than_or_equal_expression"
require_relative "greater_than_expression"
require_relative "less_than_or_equal_expression"
require_relative "less_than_expression"
require_relative "atom_expression"

require_relative "constant"
require_relative "literal"
require_relative "func_reference"
require_relative "variable_reference"
require_relative "func_call"

module LambdaLang
  class Parser
    def initialize(lexer)
      @lexer             = lexer
      @promote_statement = false
    end

    attr_reader :lexer, :promote_statement
    private     :lexer, :promote_statement

    def parse
      parse_functions
    end

    private

    def parse_functions
      functions = [ ]
      while lexer.next?
        functions << parse_function(functions)
      end
      functions
    end

    def parse_function(functions)
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
      statements = parse_statements(functions)

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

    def parse_statements(functions)
      statements = [ ]
      loop do
        @promote_statement = false

        token = lexer.next
        break if token == "}"

        statement =
          case token
          when "if"
            parse_if_statement(functions)
          when "debug"
            parse_debug_statement
          else
            lexer.unshift(token)
            SingleExpressionStatement.new(parse_expression)
          end
        if promote_statement
          name        = "__f_#{functions.size}__"
          functions  << FuncDefinition.new(name, ["_"], [statement])
          statements <<
            SingleExpressionStatement.new(
              SingleTermExpression.new(
                FuncCall.new(name, [:stack])
              )
            )
        else
          statements << statement
        end
      end
      statements
    end

    def parse_if_statement(functions)
      fail "expected conditional" unless lexer.next == "("
      conditional = parse_expression
      fail "expected end of conditional" unless lexer.next == ")"

      fail "expected true statements" unless lexer.next == "{"
      true_statements = parse_statements(functions)

      false_statements =
        if lexer.peek == "else"
          lexer.next
          fail "expected false statements" unless lexer.next == "{"
          parse_statements(functions)
        else
          [ ]
        end

      IfStatement.new(conditional, true_statements, false_statements)
    end

    def parse_debug_statement
      value = parse_expression

      DebugStatement.new(value)
    end

    def parse_expression
      if lexer.peek == "{"
        lexer.next
        parse_cons_expression
      elsif lexer.peek == "#"
        lexer.next
        AtomExpression.new(parse_term)
      else
        left = parse_term
        if %w[- + * / == >= > <= <].include?(lexer.peek)
          op    =
            case lexer.next
            when "-"  then SubtractionExpression
            when "+"  then AdditionExpression
            when "*"  then MultiplicationExpression
            when "/"  then DivisionExpression
            when "==" then EqualsExpression
            when ">=" then GreaterThanOrEqualExpression
            when ">"  then GreaterThanExpression
            when "<=" then LessThanOrEqualExpression
            when "<"  then LessThanExpression
            end
          right = parse_term
          op.new(left, right)
        else
          SingleTermExpression.new(left)
        end
      end
    end

    def parse_cons_expression
      car = parse_expression
      fail "malformed cons statement" unless lexer.next == ","
      cdr = parse_expression
      fail "expected cons statement end" unless lexer.next == "}"

      ConsExpression.new(car, cdr)
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
      when /\A\w+\z/
        if lexer.peek == "("
          FuncCall.new(token, parse_arguments)
        else
          @promote_statement = true if token == "_"
          VariableReference.new(token)
        end
      else
        fail "unknown term"
      end
    end

    def parse_arguments
      arguments = [ ]
      fail "expect argument list" unless lexer.next == "("
      loop do
        if lexer.peek == ")"
          lexer.next
          break
        end

        arguments << parse_expression

        if lexer.peek == ","
          lexer.next
        end
      end
      arguments
    end
  end
end
