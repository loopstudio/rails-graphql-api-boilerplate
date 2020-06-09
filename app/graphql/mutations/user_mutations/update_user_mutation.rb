module Mutations
  module UserMutations
    class UpdateUserMutation < Mutations::BaseMutation
      argument :attributes, Types::CustomTypes::UserAttributesType, required: true

      field :user, Types::CustomTypes::UserType, null: false

      def resolve(attributes:)
        user = User.find(context[:current_user].id)

        return { user: user } if user.update(attributes.to_hash)

        raise GraphQL::ExecutionError, user.errors.messages.to_json
      end
    end
  end
end
