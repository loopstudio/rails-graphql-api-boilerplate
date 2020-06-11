if Rails.env.development?
  GraphiQL::Rails.config.headers['Authorization'] = lambda { |_context|
    "bearer #{ENV['GRAPHIQL_SESSION_TOKEN']}"
  }
end
