if Rails.env.development?
  GraphiQL::Rails.config.headers['Authorization'] = lambda { |_context|
    "bearer #{ENV['DEV_BEARER_TOKEN']}"
  }
end
