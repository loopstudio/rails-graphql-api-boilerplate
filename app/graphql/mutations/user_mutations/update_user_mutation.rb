module Mutations
  module UserMutations
    class UpdateUserMutation < Mutations::BaseMutation
      argument :first_name, String, required: false
      argument :last_name, String, required: false
      argument :email, String, required: false
      argument :password, String, required: false

      field :user, Types::CustomTypes::UserType, null: false

      def resolve(**attributes)
        user = User.find(context[:current_user]&.id)
        user.update!(attributes)

        { user: user }
      end
    end
  end
end
