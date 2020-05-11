module Types
  module CustomTypes
    class UserType < Types::BaseObject
      implements Types::CustomTypes::FullNameType

      field :id, ID, null: false
      field :first_name, String, null: true
      field :last_name, String, null: true
      field :email, String, null: false
      field :users, [UserType], null: true
    end
  end
end
