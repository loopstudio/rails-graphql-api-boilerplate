module Mutations
  module UserMutations
    class SignInUserMutation < Mutations::BaseMutation
      argument :auth, Types::CustomTypes::AuthProviderEmailInputType, required: false

      field :token, String, null: true
      field :user, Types::CustomTypes::UserType, null: true

      def resolve(auth: nil)
        return unless auth

        user = User.find_by(email: auth[:email])
        return unless user&.authenticate(auth[:password])

        token = AuthToken.token(user)

        {user: user, token: token}
      end
    end
  end
end
