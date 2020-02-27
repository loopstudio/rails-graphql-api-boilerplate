module Types
  module Queries
    module UserQueries
      extend ActiveSupport::Concern

      included do
        field :users, [Types::CustomTypes::UserType], null: false
        field :user, Types::CustomTypes::UserType, null: false do
          argument :id, GraphQL::Types::ID, required: true
        end
      end

      def users
        User.order(:id)
      end

      def user(id:)
        Loaders::RecordLoader.for(User).load(id)
      end
    end
  end
end