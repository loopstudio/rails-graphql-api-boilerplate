module Mutations
  module UserMutations
    class CreateUserMutation < Mutations::BaseMutation
      argument :attributes, Types::CustomTypes::UserAttributesType, required: true

      field :user, Types::CustomTypes::UserType, null: true
      field :errors, [String], null: true
      field :token, String, null: true

      def resolve(attributes:)
        user = User.new(attributes.to_hash)
        if user.save
          token = AuthToken.token(user)
          { user: user, token: token, errors: [] }
        else
          { user: nil, token: nil, errors: user.errors.full_messages }
        end
      end
    end
  end
end
