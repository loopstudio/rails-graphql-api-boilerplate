module Types
  class BookType < Types::BaseObject
    field :id, ID, null: false
    field :title, String, null: false
    field :user, Types::UserType, null: false, resolve: -> (obj, args, ctx) {
      RecordLoader.for(User).load(obj.user_id)
    }
    field :publisher, Types::PublisherType, null: false, resolve: -> (obj, args, ctx) {
      RecordLoader.for(Publisher).load(obj.publisher_id)
    }
  end
end
