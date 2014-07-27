require_relative "lambda_lang/lexer"
require_relative "lambda_lang/parser"
require_relative "lambda_lang/compiler"

module LambdaLang
  module_function

  def compile(input, output = $stdout)
    lexer     = Lexer.new(input.read)
    parser    = Parser.new(lexer)
    functions = parser.parse
    compiler  = Compiler.new(functions)
    output.puts compiler.compile
  rescue => error
    raise "#{error.message} (lexer:  #{lexer.rest[0..20].inspect})"
  end
end
