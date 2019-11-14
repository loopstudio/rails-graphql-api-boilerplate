module Types
  module CustomTypes
    class UserType < Types::BaseObject
      implements Types::CustomTypes::FullNameType

      field :id, ID, null: false
      field :first_name, String, null: true
      field :last_name, String, null: true
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
          Loaders::AssociationLoader.for(User, :books).load(object)
        }
      )
      field(
        :publishers,
        [Types::CustomTypes::PublisherType],
        null: true,
        resolve: lambda { |object, _args, _context|
          Loaders::AssociationLoader.for(User, :publishers).load(object)
        }
      )
      field :books_count, Integer, null: true

      def books_count
        object.books.size
      end
    end
  end
end
