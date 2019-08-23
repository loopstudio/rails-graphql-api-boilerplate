module Types
  class CountryType < Types::BaseObject
    field :id, ID, null: false
    field :name, String, null: true
    field :capital, String, null: true
    field :users, [Types::UserType], null: true, resolve: -> (obj, args, ctx) do
      Loaders::AssociationLoader.for(Country, :users).load(obj)
    end
    field :books, [Types::BookType], null: true, resolve: -> (obj, args, ctx) do
      Loaders::AssociationLoader.for(Country, :books).load(obj)
    end
  end
end
