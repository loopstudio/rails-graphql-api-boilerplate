class RailsApiBoilerplateSchema < GraphQL::Schema
  # max_complexity 5
  # max_depth 3

  use GraphQL::Subscriptions::ActionCableSubscriptions, redis: Redis.new
  use GraphQL::Batch

  query_analyzer(QueryAnalyzer.new)
  mutation(Types::MutationType)
  query(Types::QueryType)
  subscription(Types::SubscriptionType)
end
