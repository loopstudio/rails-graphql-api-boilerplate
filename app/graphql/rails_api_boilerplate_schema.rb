class RailsApiBoilerplateSchema < GraphQL::Schema
  disable_introspection_entry_points unless GraphqlConfig::EXPOSE_API_INSIGHTS
  use GraphQL::Subscriptions::ActionCableSubscriptions, redis: Redis.new
  use GraphQL::Batch
  query_analyzer QueryAnalyzers::QueryComplexityAnalyzer
  query_analyzer QueryAnalyzers::QueryDepthAnalyzer

  mutation(Types::MutationType)
  query(Types::QueryType)
  subscription(Types::SubscriptionType)

  rescue_from(ActiveRecord::RecordInvalid) do |exception|
    errors = exception.record.errors.messages.to_json
    GraphQL::ExecutionError.new(errors, extensions: { code: :bad_request })
  end

  rescue_from(ActiveRecord::RecordNotFound) do |exception|
    GraphQL::ExecutionError.new(exception, extensions: { code: :not_found })
  end

  rescue_from(StandardError) do |exception|
    GraphQL::ExecutionError.new(exception, extensions: { code: :internal_server_error })
  end
end
