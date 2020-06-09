module Types
  class QueryType < Types::BaseObject
    field :user, resolver: Queries::User
  end
end
