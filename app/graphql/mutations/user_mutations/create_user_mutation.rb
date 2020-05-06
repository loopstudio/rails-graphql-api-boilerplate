module Mutations
  module UserMutations
    class CreateUserMutation < Mutations::BaseMutation
      argument :attributes, Types::CustomTypes::UserAttributesType, required: true

      field :user, Types::CustomTypes::UserType, null: false
      field :token, String, null: true

      attr_reader :user

      def resolve(attributes:)
        @user = User.create!(attributes.to_hash)
        token = AuthToken.token(user)
        { user: user, token: token }
      end
    end
  end
end
