require_relative "../constants"

module LambdaLang
  class Constant
    LOOKUP_TABLE = ::DIRECTIONS.merge(::MAP)

    def initialize(name)
      @name = name
    end

    attr_reader :name

    def value
      LOOKUP_TABLE[name.downcase.to_sym]
    end
  end
end
