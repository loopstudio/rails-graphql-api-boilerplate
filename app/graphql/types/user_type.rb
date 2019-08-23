module Types
  class UserType < Types::BaseObject
    field :id, ID, null: false
    field :first_name, String, null: true
    field :last_name, String, null: true
    field :country, Types::CountryType, null: true, resolve: -> (obj, args, ctx) do
      Loaders::RecordLoader.for(Country).load(obj.country_id)
    end
    field :books, [Types::BookType], null: true, resolve: -> (obj, args, ctx) do
      Loaders::AssociationLoader.for(User, :books).load(obj)
    end
    field :publishers, [Types::PublisherType], null: true, resolve: -> (obj, args, ctx) do
      Loaders::AssociationLoader.for(User, :publishers).load(obj)
    end
    field :books_count, Integer, null: true

    def books_count
      object.books.size
    end
  end
end
