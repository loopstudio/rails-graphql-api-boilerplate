module Mutations
  module UserMutations
    class SignInUserMutation < Mutations::BaseMutation
      argument :email, String, required: true
      argument :password, String, required: true

      field :user, Types::CustomTypes::UserType, null: true
      field :token, String, null: true

      def resolve(email:, password:)
        user = User.find_by(email: email)

        unless user&.authenticate(password)
          raise GraphQL::ExecutionError, I18n.t('errors.invalid_credentials')
        end

        token = AuthToken.token(user)
        { user: user, token: token }
      end
    end
  end
end
