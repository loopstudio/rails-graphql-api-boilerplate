module Mutations
  module UserMutations
    class CreateUserMutation < Mutations::BaseMutation
      argument :attributes, Types::CustomTypes::UserAttributesType, required: true

      field :user, Types::CustomTypes::UserType, null: false
      field :token, String, null: true

      def resolve(attributes:)
        user = User.new(attributes.to_hash)

        raise GraphQL::ExecutionError, user.errors.messages.to_json unless user.save

        token = AuthToken.token(user)
        { user: user, token: token }
      end
    end
  end
end
