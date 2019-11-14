module Types
  module Queries
    module CountryQueries
      extend ActiveSupport::Concern

      included do
        field :countries, [Types::CustomTypes::CountryType], null: false
        field :country, Types::CustomTypes::CountryType, null: false do
          argument :id, GraphQL::Types::ID, required: true
        end
      end

      def countries
        Country.all
      end

      def country(id:)
        Loaders::RecordLoader.for(Country).load(id)
      end
    end
  end
end
