module Types
  class QueryType < Types::BaseObject
    field :users, [Types::UserType], null: false
    field :books, [Types::BookType], null: false
    field :countries, [Types::CountryType], null: false
    field :publishers, [Types::PublisherType], null: false

    def countries
      Country.all
    end

    def publishers
      Publisher.all
    end

    def books
      Book.where(user: context[:current_user])
    end

    def users
      User.order(:id)
    end

    field :user, Types::UserType, null: false do
      argument :id, ID, required: true
    end

    field :book, Types::BookType, null: false do
      argument :id, ID, required: true
    end

    field :country, Types::CountryType, null: false do
      argument :id, ID, required: true
    end

    field :publisher, Types::PublisherType, null: false do
      argument :id, ID, required: true
    end

    def user(id:)
      Loaders::RecordLoader.for(User).load(id)
    end

    def book(id:)
      Loaders::RecordLoader.for(Book).load(id)
    end

    def country(id:)
      Loaders::RecordLoader.for(Country).load(id)
    end

    def publisher(id:)
      Loaders::RecordLoader.for(Publisher).load(id)
    end
  end
end
