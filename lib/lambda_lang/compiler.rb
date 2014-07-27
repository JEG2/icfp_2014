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
require_relative "list_expression"

require_relative "constant"
require_relative "literal"
require_relative "func_reference"
require_relative "variable_reference"
require_relative "func_call"
require_relative "anonymous_func_call"

module LambdaLang
  class Compiler
    def initialize(functions)
      @functions  = functions
      @lines      = [ ]
      @next_notes = [ ]
      @branches   = [ ]
    end

    attr_reader :functions, :lines, :next_notes, :branches
    private     :functions, :lines, :next_notes, :branches

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
      next_notes << "func/#{function.name}"
      function.statements.each do |statement|
        compile_statement(statement, function)
      end
      write "RTN", "func/#{function.name}"
      branches.each_slice(2).with_index do |(if_branch, else_branch), i|
        compile_branch("if/#{i}",   if_branch,   function)
        compile_branch("else/#{i}", else_branch, function)
      end
      branches.clear
    end

    def compile_branch(name, branch, function)
      next_notes << name unless branch.empty?
      branch.each do |statement|
        compile_statement(statement, function)
      end
      write "JOIN", name
    end

    def compile_statement(statement, function)
      case statement
      when IfStatement
        compile_if_statement(statement, function)
      when DebugStatement
        compile_expression(statement.value, function)
        write "DBUG"
      when SingleExpressionStatement
        compile_expression(statement.expression, function)
       else
        fail "unknown statement type"
      end
    end

    def compile_if_statement(statement, function)
      compile_expression(statement.conditional, function)
      branch = branches.size / 2
      write "SEL >if/#{branch} >else/#{branch}", "if_else/#{branch}"
      branches << statement.true_statements << statement.false_statements
    end

    def compile_expression(expression, function)
      case expression
      when ConsExpression
        compile_expression(expression.car, function)
        compile_expression(expression.cdr, function)
        write "CONS"
      when ListExpression
        next_notes << "list/head"
        expression.elements.each do |element|
          compile_expression(element, function)
        end
        write "LDC 0", "list/tail"
        expression.elements.size.times do
          write "CONS"
        end
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
      when EqualsExpression
        compile_term(expression.left, function)
        compile_term(expression.right, function)
        write "CEQ"
      when GreaterThanExpression
        compile_term(expression.left, function)
        compile_term(expression.right, function)
        write "CGT"
      when GreaterThanOrEqualExpression
        compile_term(expression.left, function)
        compile_term(expression.right, function)
        write "CGTE"
      when LessThanExpression
        compile_term(expression.right, function)
        compile_term(expression.left,  function)
        write "CGT"
      when LessThanOrEqualExpression
        compile_term(expression.right, function)
        compile_term(expression.left, function)
        write "CGTE"
      when AtomExpression
        compile_term(expression.value, function)
        write "ATOM"
      when Car
        compile_expression(expression.cons, function)
        write "CAR"
      when Cdr
        compile_expression(expression.cons, function)
        write "CDR"
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
        fail "unknown variable:  #{term.name}" unless i
        write "LD 0 #{i}", "var/#{term.name}"
      when FuncCall
        term.arguments.each do |argument|
          next if argument == :stack
          compile_expression(argument, function)
        end
        write "LDF &#{term.name}"
        func = functions.find { |f| f.name == term.name }
        fail "failed to find named func:  #{term.name}" unless func
        write "AP #{func.parameters.size}", "call/#{term.name}"
      when AnonymousFuncCall
        term.arguments.each do |argument|
          next if argument == :stack
          compile_expression(argument, function)
        end
        compile_term(VariableReference.new(term.name), function)
        write "AP #{term.arguments.size}", "call/&#{term.name}"
      end
    end

    def write(code, notes = [ ])
      lines << [code, next_notes + Array(notes)]
      next_notes.clear
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
      lines.each_with_index do |line, i|
        line.first.sub!(/\ALDF\s+&(\w+)\z/) {
          i = lines.find_index { |_, notes| notes.include?('func/' + $1) }
          fail "unknown reference:  #{$1}" unless i
          "LDF #{i}"
        }
        line.first.gsub!(/>((?:if|else)\/\d+)/) {
          lines[i..-1].find_index { |_, notes| notes.include?($1) } + i
        }
      end
    end
  end
end
