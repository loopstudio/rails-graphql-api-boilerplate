class RailsApiBoilerplateSchema < GraphQL::Schema
  max_complexity 5
  max_depth 3

  mutation(Types::MutationType)
  query(Types::QueryType)
  use(GraphQL::Batch)
end
