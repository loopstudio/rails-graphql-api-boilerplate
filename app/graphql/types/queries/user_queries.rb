module Types
  module Queries
    module UserQueries
      extend ActiveSupport::Concern

      included do
        field :user, Types::CustomTypes::UserType, null: false
      end

      # :reek:UtilityFunction
      def user
        context[:current_user]
      end
    end
  end
end
