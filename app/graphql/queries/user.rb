module Queries
  class User < Queries::BaseQuery
    type Types::CustomTypes::UserType, null: false

    def resolve
      context[:current_user]
    end
  end
end
