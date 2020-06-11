module Mutations
  module UserMutations
    class CreateUserMutation < Mutations::BaseMutation
      argument :first_name, String, required: true
      argument :last_name, String, required: true
      argument :email, String, required: true
      argument :password, String, required: true

      field :user, Types::CustomTypes::UserType, null: false
      field :token, String, null: false

      def resolve(**attributes)
        user = User.create!(attributes)
        token = AuthToken.token(user)

        { user: user, token: token }
      end
    end
  end
end
