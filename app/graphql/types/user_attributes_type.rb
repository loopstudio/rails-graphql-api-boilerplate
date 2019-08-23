module Types
  class UserAttributesType < Types::BaseInputObject
    description 'Attributes for creating or updating a user'
    argument :first_name, String, 'First name (used to compose the full name)', required: true
    argument :last_name, String, 'Last name (used to compose the full name)', required: true
  end
end
