module Types
  module CustomTypes
    class PublisherType < Types::BaseObject
      field :id, ID, null: false
      field :name, String, null: true
      field(
        :country,
        Types::CustomTypes::CountryType,
        null: true,
        resolve: lambda { |object, _args, _context|
          Loaders::RecordLoader.for(Country).load(object.country_id)
        }
      )
      field(
        :books,
        [Types::CustomTypes::BookType],
        null: true,
        resolve: lambda { |object, _args, _context|
          Loaders::AssociationLoader.for(Publisher, :books).load(object)
        }
      )
      field(
        :users,
        [Types::CustomTypes::UserType],
        null: true,
        resolve: lambda { |object, _args, _context|
          Loaders::AssociationLoader.for(Publisher, :users).load(object)
        }
      )
      field :books_count, Integer, null: false

      def books_count
        object.books.size
      end
    end
  end
end
