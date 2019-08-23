module Mutations
  class UpdateUserMutation < Mutations::BaseMutation
    argument :id, ID, required: true
    argument :attributes, Types::UserAttributesType, required: true

    field :user, Types::UserType, null: false
    field :errors, [String], null: false

    def resolve(id:, attributes:)
      user = User.find(id)
      if user.update_attributes(attributes.to_hash)
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
