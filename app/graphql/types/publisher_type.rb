module Types
  class PublisherType < Types::BaseObject
    field :id, ID, null: false
    field :name, String, null: true
    field :country, Types::CountryType, null: true, resolve: -> (obj, args, ctx) do
      Loaders::RecordLoader.for(Country).load(obj.country_id)
    end
    field :books, [Types::BookType], null: true, resolve: -> (obj, args, ctx) do
      Loaders::AssociationLoader.for(Publisher, :books).load(obj)
    end
    field :users, [Types::UserType], null: true, resolve: -> (obj, args, ctx) do
      Loaders::AssociationLoader.for(Publisher, :users).load(obj)
    end
    field :books_count, Integer, null: false

    def books_count
      object.books.size
    end
  end
end
