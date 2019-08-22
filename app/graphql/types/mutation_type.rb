module Types
  class MutationType < Types::BaseObject
    field :create_user, mutation: Mutations::CreateUserMutation
    field :delete_user, mutation: Mutations::DeleteUserMutation
    field :update_user, mutation: Mutations::UpdateUserMutation
  end
end
