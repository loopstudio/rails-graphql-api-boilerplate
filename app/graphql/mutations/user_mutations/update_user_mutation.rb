module Mutations
  module UserMutations
    class UpdateUserMutation < Mutations::BaseMutation
      argument :id, ID, required: true
      argument :attributes, Types::CustomTypes::UserAttributesType, required: true

      field :user, Types::CustomTypes::UserType, null: false
      field :errors, [String], null: false

      def resolve(id:, attributes:)
        user = User.find(id)
        if user.update_attributes(attributes.to_hash)
          { user: user, errors: [] }
        else
          { user: nil, errors: user.errors.full_messages }
        end
      end
    end
  end
end
