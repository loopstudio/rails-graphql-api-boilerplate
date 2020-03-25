class RailsApiBoilerplateSchema < GraphQL::Schema
  use GraphQL::Subscriptions::ActionCableSubscriptions, redis: Redis.new
  use GraphQL::Batch

  query_analyzer(QueryAnalyzer.new)
  mutation(Types::MutationType)
  query(Types::QueryType)
  subscription(Types::SubscriptionType)
end
