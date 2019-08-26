module Mutations
  class SignInUserMutation < Mutations::BaseMutation
    argument :auth, Types::AuthProviderEmailInputType, required: false

    field :token, String, null: true
    field :user, Types::UserType, null: true

    def resolve(auth: nil)
      return unless auth

      user = User.find_by(email: auth[:email])
      return unless user&.authenticate(auth[:password])

      token = AuthToken.token(user)

      {user: user, token: token}
    end
  end
end
