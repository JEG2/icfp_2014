require_relative "debug_statement"
require_relative "single_expression_statement"

require_relative "cons_expression"
require_relative "addition_expression"
require_relative "subtraction_expression"
require_relative "multiplication_expression"
require_relative "division_expression"
require_relative "single_term_expression"

require_relative "constant"
require_relative "literal"
require_relative "func_reference"
require_relative "variable_reference"
require_relative "func_call"


module LambdaLang
  class Compiler
    def initialize(functions)
      @functions  = functions
      @lines      = [ ]
      @next_notes = [ ]
    end

    attr_reader :functions, :lines, :next_notes
    private     :functions, :lines, :next_notes

    def compile
      main, rest = functions.partition { |function| function.name == "main" }
      fail "main function required"      if main.empty?
      fail "main must return a function" if rest.empty?

      compile_functions(main + rest)
      resolve_references

      build_pretty_lines
    end

    private

    def compile_functions(ordered_functions)
      ordered_functions.each do |function|
        compile_function(function)
      end
    end

    def compile_function(function)
      @next_notes << "func/#{function.name}"
      function.statements.each do |statement|
        compile_statement(statement, function)
      end
      write "RTN", "func/#{function.name}"
    end

    def compile_statement(statement, function)
      case statement
      when DebugStatement
        compile_expression(statement.value, function)
        write "DBUG"
      when SingleExpressionStatement
        compile_expression(statement.expression, function)
       else
        fail "unknown statement type"
      end
    end

    def compile_expression(expression, function)
      case expression
      when ConsExpression
        compile_expression(expression.car, function)
        compile_expression(expression.cdr, function)
        write "CONS"
      when AdditionExpression
        compile_term(expression.left, function)
        compile_term(expression.right, function)
        write "ADD"
      when SubtractionExpression
        compile_term(expression.left, function)
        compile_term(expression.right, function)
        write "SUB"
      when MultiplicationExpression
        compile_term(expression.left, function)
        compile_term(expression.right, function)
        write "MUL"
      when DivisionExpression
        compile_term(expression.left, function)
        compile_term(expression.right, function)
        write "DIV"
      when SingleTermExpression
        compile_term(expression.term, function)
      end
    end

    def compile_term(term, function)
      case term
      when Literal
        write "LDC #{term.value}"
      when Constant
        write "LDC #{term.value}", "const/#{term.name}"
      when FuncReference
        write "LDF &#{term.name}"
      when VariableReference
        i = function.parameters.index(term.name)
        fail "unknown variable" unless i
        write "LD 0 #{i}", "var/#{term.name}"
      when FuncCall
        term.arguments.each do |argument|
          next if argument == :stack
          compile_expression(argument, function)
        end
        write "LDF &#{term.name}"
        write "AP #{term.arguments.size}", "call/#{term.name}"
      end
    end

    def write(code, notes = [ ])
      lines << [code, next_notes + Array(notes)]
      @next_notes.clear
    end

    def build_pretty_lines
      max_code_width = lines.map { |code, _| code.size }.max
      lines.map.with_index { |(code, notes), i|
        line  = "%-#{max_code_width + 2}s; %i" % [code, i]
        line << ": #{notes.join(': ')}" unless notes.empty?
        line + "\n"
      }
    end

    def resolve_references
      lines.each do |line|
        line.first.gsub!(/\ALDF\s+&(\w+)\z/) {
          "LDF #{lines.find_index { |_, notes| notes.include?('func/' + $1) }}"
        }
      end
    end
  end
end
