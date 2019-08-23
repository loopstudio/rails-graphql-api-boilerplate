module Mutations
  class CreateUserMutation < Mutations::BaseMutation
    argument :attributes, Types::UserAttributesType, required: true

    field :user, Types::UserType, null: false
    field :errors, [String], null: false

    def resolve(attributes:)
      user = User.new(attributes.to_hash)
      if user.save
        {
          user: user,
          errors: [],
        }
      else
        {
          user: nil,
          errors: user.errors.full_messages
        }
      end
    end
  end
end
