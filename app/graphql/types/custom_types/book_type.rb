module Types
  module CustomTypes
    class BookType < Types::BaseObject
      field :id, ID, null: false
      field :title, String, null: false
      field(
        :user,
        Types::CustomTypes::UserType,
        null: false,
        resolve: lambda { |object, _args, _context|
          Loaders::RecordLoader.for(User).load(object.user_id)
        }
      )
      field(
        :publisher,
        Types::CustomTypes::PublisherType,
        null: false,
        resolve: lambda { |object, _args, _context|
          Loaders::RecordLoader.for(Publisher).load(object.publisher_id)
        }
      )
    end
  end
end
