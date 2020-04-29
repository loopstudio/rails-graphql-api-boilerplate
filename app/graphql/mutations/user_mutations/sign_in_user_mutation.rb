module Mutations
  module UserMutations
    class SignInUserMutation < Mutations::BaseMutation
      argument :attributes, Types::CustomTypes::AuthProviderEmailInputType, required: false

      field :user, Types::CustomTypes::UserType, null: true
      field :token, String, null: true

      def resolve(attributes:)
        user = User.find_by(email: attributes[:email])

        if user&.authenticate(attributes[:password])
          token = AuthToken.token(user)
          { user: user, token: token }
        else
          render_error(I18n.t('errors.invalid_credentials'))
        end
      end
    end
  end
end
