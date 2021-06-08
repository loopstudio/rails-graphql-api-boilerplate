GraphiQL::Rails.config.headers['Authorization'] = lambda { |_context|
  token = ENV['GRAPHIQL_SESSION_TOKEN']
  token.present? ? "Bearer #{token}" : ''
}
