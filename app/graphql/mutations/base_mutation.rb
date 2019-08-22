class Mutations::BaseMutation < GraphQL::Schema::RelayClassicMutation
  object_class Types::BaseObject
  field_class Types::BaseField
  input_object_class Types::BaseInputObject
end
