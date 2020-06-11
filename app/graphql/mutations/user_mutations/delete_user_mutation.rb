module Mutations
  module UserMutations
    class DeleteUserMutation < Mutations::BaseMutation
      field :user, Types::CustomTypes::UserType, null: false

      def resolve
        user = User.find(context[:current_user]&.id)
        user.destroy!

        { user: user }
      end
    end
  end
end
