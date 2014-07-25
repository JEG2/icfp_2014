require_relative "lambda_lang/lexer"
require_relative "lambda_lang/parser"
require_relative "lambda_lang/compiler"

module LambdaLang
  module_function

  def compile(path, output = $stdout)
    code      = File.read(path)
    lexer     = Lexer.new(code)
    parser    = Parser.new(lexer)
    functions = parser.parse
    compiler  = Compiler.new(functions)
    output.puts compiler.compile
  end
end
