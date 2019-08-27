module Types
  module Queries
    module PublisherQueries
      extend ActiveSupport::Concern

      included do
        field :publishers, [Types::CustomTypes::PublisherType], null: false
        field :publisher, Types::CustomTypes::PublisherType, null: false do
          argument :id, GraphQL::Types::ID, required: true
        end
      end

      def publishers
        Publisher.all
      end

      def publisher(id:)
        Loaders::RecordLoader.for(Publisher).load(id)
      end
    end
  end
end
