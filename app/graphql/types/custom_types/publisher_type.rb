module Types
  module CustomTypes
    class PublisherType < Types::BaseObject
      field :id, ID, null: false
      field :name, String, null: true
      field :country, Types::CustomTypes::CountryType, null: true, resolve: -> (object, args, context) do
        Loaders::RecordLoader.for(Country).load(object.country_id)
      end
      field :books, [Types::CustomTypes::BookType], null: true, resolve: -> (object, args, context) do
        Loaders::AssociationLoader.for(Publisher, :books).load(object)
      end
      field :users, [Types::CustomTypes::UserType], null: true, resolve: -> (object, args, context) do
        Loaders::AssociationLoader.for(Publisher, :users).load(object)
      end
      field :books_count, Integer, null: false

      def books_count
        object.books.size
      end
    end
  end
end
