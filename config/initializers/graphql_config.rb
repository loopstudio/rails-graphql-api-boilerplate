module GraphqlConfig
  EXPOSE_API_INSIGHTS = ENV.fetch('EXPOSE_API_INSIGHTS', 'false') == 'true'
end
