module Types
  class EventType < Types::BaseObject
    field :id, ID, null: false
    field :field_name, String, null: true
  end
end
