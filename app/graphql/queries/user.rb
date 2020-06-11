module Queries
  class User < Queries::BaseQuery
    type Types::CustomTypes::UserType, null: true

    def resolve
      context[:current_user]
    end
  end
end
