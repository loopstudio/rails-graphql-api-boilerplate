module Types
  module CustomTypes
    class UrlType < Types::BaseScalar
      description 'A valid URL, transported as a string'

      def self.coerce_input(input_value, _context)
        url = URI.parse(input_value)
        unless url.is_a?(URI::HTTP) || url.is_a?(URI::HTTPS)
          raise GraphQL::CoercionError, "#{input_value.inspect} is not a valid URL"
        end

        url
      end

      def self.coerce_result(ruby_value, _context)
        ruby_value.to_s
      end
    end
  end
end
