module Mutations
  module UserMutations
    class DeleteUserMutation < Mutations::BaseMutation
      argument :id, ID, required: true

      field :user, Types::CustomTypes::UserType, null: false

      attr_reader :user

      def resolve(id:)
        @user = User.find(id)

        return { user: user } if user.destroy

        raise GraphQL::ExecutionError, user.errors.messages.to_json
      end
    end
  end
end
