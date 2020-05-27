module Types
  class BaseObject < GraphQL::Schema::Object
    def self.connection_type
      connection_class = super

      connection_class.define_method(:total_count) do
        object.nodes.size
      end

      connection_class.send(:field, :total_count, Integer, null: false)

      connection_class
    end
  end
end
