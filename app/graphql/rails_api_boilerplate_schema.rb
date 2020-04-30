class RailsApiBoilerplateSchema < GraphQL::Schema
  use GraphQL::Subscriptions::ActionCableSubscriptions, redis: Redis.new
  use GraphQL::Batch

  mutation(Types::MutationType)
  query(Types::QueryType)
  subscription(Types::SubscriptionType)

  rescue_from(StandardError) do |message|
    GraphQL::ExecutionError.new(message, extensions: { code: :internal_server_error })
  end

  rescue_from(ActiveRecord::RecordInvalid) do |_message|
    errors = exception.record.errors.messages.to_json
    GraphQL::ExecutionError.new(errors, extensions: { code: :bad_request })
  end

  rescue_from(ActiveRecord::RecordNotFound) do |message|
    GraphQL::ExecutionError.new(message, extensions: { code: :not_found })
  end
end
