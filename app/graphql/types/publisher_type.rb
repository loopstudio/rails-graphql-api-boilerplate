module Types
  class PublisherType < Types::BaseObject
    field :id, ID, null: false
    field :name, String, null: true
    field :country, Types::CountryType, null: true, resolve: -> (obj, args, ctx) {
      RecordLoader.for(Country).load(obj.country_id)
    }
    field :books, [Types::BookType], null: true, resolve: -> (obj, args, ctx) {
      AssociationLoader.for(Publisher, :books).load(obj)
    }
    field :users, [Types::UserType], null: true, resolve: -> (obj, args, ctx) {
      AssociationLoader.for(Publisher, :users).load(obj)
    }
    field :books_count, Integer, null: false

    def books_count
      object.books.size
    end
  end
end
