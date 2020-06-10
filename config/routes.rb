Rails.application.routes.draw do
  if GraphqlConfig::EXPOSE_API_INSIGHTS
    mount GraphiQL::Rails::Engine, at: '/graphiql', graphql_path: 'graphql#execute'
  end

  mount ActionCable.server, at: '/cable'
  post '/graphql', to: 'graphql#execute'
end
