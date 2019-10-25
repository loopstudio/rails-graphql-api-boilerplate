module Types
  class SubscriptionType < Types::BaseObject
    field(
      :user_updated,
      Types::CustomTypes::UserType,
      null: false,
      description: 'A user has been updated'
    )

    def user_updated; end
  end
end
