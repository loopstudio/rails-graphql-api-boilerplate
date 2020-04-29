module Mutations
  class BaseMutation < GraphQL::Schema::RelayClassicMutation
    object_class Types::BaseObject
    field_class Types::BaseField
    input_object_class Types::BaseInputObject

    def render_error(errors)
      raise GraphQL::ExecutionError.new(errors, extensions: { code: :bad_request })
    end
  end
end
