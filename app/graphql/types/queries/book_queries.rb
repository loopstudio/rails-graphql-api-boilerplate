module Types
  module Queries
    module BookQueries
      extend ActiveSupport::Concern

      included do
        field :books, [Types::CustomTypes::BookType], null: false
        field :book, Types::CustomTypes::BookType, null: false do
          argument :id, GraphQL::Types::ID, required: true
        end
      end

      def books
        Book.where(user: context[:current_user])
      end

      def book(id:)
        Loaders::RecordLoader.for(Book).load(id)
      end
    end
  end
end
