module Types
  module CustomTypes
    class UserAttributesType < Types::BaseInputObject
      description 'Attributes for creating or updating a user'

      argument :first_name, String, 'FirstName', required: true
      argument :last_name, String, 'LastName', required: true
      argument :email, String, 'Email', required: true
      argument :password, String, 'Password', required: true
    end
  end
end
