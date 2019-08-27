module Mutations
  module UserMutations
    class CreateUserMutation < Mutations::BaseMutation
      argument :attributes, Types::CustomTypes::UserAttributesType, required: true

      field :user, Types::CustomTypes::UserType, null: false
      field :errors, [String], null: false

      def resolve(attributes:)
        user = User.new(attributes.to_hash)
        if user.save
          {user: user, errors: []}
        else
          {user: nil, errors: user.errors.full_messages}
        end
      end
    end
  end
end
