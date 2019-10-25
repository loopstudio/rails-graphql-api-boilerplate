module Types
  module CustomTypes
    class CountryType < Types::BaseObject
      field :id, ID, null: false
      field :name, String, null: true
      field :capital, String, null: true
      field(
        :users,
        [Types::CustomTypes::UserType],
        null: true,
        resolve: lambda { |object, _args, _context|
          Loaders::AssociationLoader.for(Country, :users).load(object)
        }
      )
      field(
        :books,
        [Types::CustomTypes::BookType],
        null: true,
        resolve: lambda { |object, _args, _context|
          Loaders::AssociationLoader.for(Country, :books).load(object)
        }
      )
    end
  end
end
