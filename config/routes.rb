Rails.application.routes.draw do
  if ENV.fetch('MOUNT_GRAPHIQL', 'false') == 'true'
    mount GraphiQL::Rails::Engine, at: '/graphiql', graphql_path: 'graphql#execute'
  end

  mount ActionCable.server, at: '/cable'
  post '/graphql', to: 'graphql#execute'
end
