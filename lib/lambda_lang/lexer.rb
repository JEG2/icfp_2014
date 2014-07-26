require "strscan"

module LambdaLang
  class Lexer
    TOKEN_REGEX = /(?:\w+|[-+*\/(){},&])/

    def initialize(code)
      @code = StringScanner.new(code)

      consume_whitespace
    end

    attr_reader :code
    private     :code

    def next
      code.scan(TOKEN_REGEX).tap do
        consume_whitespace
      end
    end

    def next?
      !code.eos?
    end

    def peek
      code.check(TOKEN_REGEX)
    end

    def unshift(token)
      code.string = "#{token} #{code.rest}"
    end

    def rest
      code.rest
    end

    private

    def consume_whitespace
      code.scan(/\s+/)
    end
  end
end
