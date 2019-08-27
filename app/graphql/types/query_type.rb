module Types
  class QueryType < Types::BaseObject
    include Types::Queries::UserQueries
    include Types::Queries::BookQueries
    include Types::Queries::CountryQueries
    include Types::Queries::PublisherQueries
    include Types::Queries::EventQueries
  end
end
