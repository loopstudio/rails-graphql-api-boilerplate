module Types
  class QueryType < Types::BaseObject
    field :users, [Types::UserType], null: false
    field :books, [Types::BookType], null: false
    field :countries, [Types::CountryType], null: false
    field :publishers, [Types::PublisherType], null: false
    field :events, [Types::EventType], null: false

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

    def events
      Event.all
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

    field :event, Types::EventType, null: false do
      argument :id, ID, required: true
    end

    field :events_by_name, Integer, null: false do
      argument :name, String, required: true
    end

    def events_by_name(name:)
      Event.where(field_name: name).size
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

    def event(id:)
      Loaders::RecordLoader.for(Event).load(id)
    end
  end
end
