module Types
  module Queries
    module EventQueries
      extend ActiveSupport::Concern

      included do
        field :events, [Types::CustomTypes::EventType], null: false
        field :event, Types::CustomTypes::EventType, null: false do
          argument :id, GraphQL::Types::ID, required: true
        end
        field :events_by_name, Integer, null: false do
          argument :name, GraphQL::Types::String, required: true
        end
      end

      def events
        Event.all
      end

      def event(id:)
        Loaders::RecordLoader.for(Event).load(id)
      end

      def events_by_name(name:)
        Event.where(field_name: name).size
      end
    end
  end
end
