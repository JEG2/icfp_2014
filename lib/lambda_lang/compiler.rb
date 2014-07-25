require_relative "cons_statement"
require_relative "constant"
require_relative "func_reference"
require_relative "literal"

module LambdaLang
  class Compiler
    def initialize(functions)
      @functions = functions
      @lines     = [ ]
      @next_note = nil
    end

    attr_reader :functions, :lines, :next_note
    private     :functions, :lines, :next_note

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
      @next_note = function.name
      function.statements.each do |statement|
        compile_statement(statement)
      end
      write "RTN", function.name
    end

    def compile_statement(statement)
      case statement
      when ConsStatement
        compile_term(statement.car)
        compile_term(statement.cdr)
        write "CONS"
      else
        fail "unknown statement type"
      end
    end

    def compile_term(term)
      case term
      when Literal
        write "LDC #{term.value}"
      when Constant
        write "LDC #{term.value}", term.name
      when FuncReference
        write "LDF &#{term.name}"
      end
    end

    def write(code, note = next_note)
      lines     << [code, note]
      @next_note = nil
    end

    def build_pretty_lines
      max_code_width = lines.map { |code, _| code.size }.max
      lines.map.with_index { |(code, note), i|
        line  = "%-#{max_code_width + 2}s; %i" % [code, i]
        line << ": #{note}" if note
        line + "\n"
      }
    end

    def resolve_references
      lines.each do |line|
        line.first.gsub!(/\ALDF\s+&(\w+)\z/) {
          "LDF #{lines.find_index { |_, note| note == $1 }}"
        }
      end
    end
  end
end
