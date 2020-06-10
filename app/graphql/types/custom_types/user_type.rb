module Types
  module CustomTypes
    class UserType < Types::BaseObject
      field :id, ID, null: false
      field :first_name, String, null: true
      field :last_name, String, null: true
      field :email, String, null: false
    end
  end
end
