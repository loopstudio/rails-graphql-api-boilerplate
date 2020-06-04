module GraphqlUtils
  class ParseErrorBetterPrinted < ::GraphQL::ParseError
    def initialize(exc)
      super(exc.message, exc.line, exc.col, exc.query)
    end

    def to_s
      "#{super}\n\n#{query}"
    end
  end

  def self.hash_to_gql(attributes)
    attr_gql_lines = attributes.map do |key, value|
      new_key = key.to_s.camelize(:lower)
      "#{new_key}: #{value.inspect || '""'}"
    end

    " { #{attr_gql_lines.join(', ')} } "
  end

  def self.validate!(some_string)
    GraphQL.parse(some_string)
  rescue ::GraphQL::ParseError => e
    raise ParseErrorBetterPrinted, e
  end
end
