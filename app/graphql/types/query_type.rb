module Types
  class QueryType < Types::BaseObject
    include Types::Queries::UserQueries
    include Types::Queries::EventQueries
  end
end
