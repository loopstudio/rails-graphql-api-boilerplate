module RequestHelpers
  def auth_headers(some_user = user)
    { 'Authorization' => AuthToken.token(some_user) }
  end

  def errors
    json[:errors]
  end

  def first_error_message
    errors.first[:message]
  end

  def json
    raise 'Response is nil. Are you sure you made a request?' unless response

    JSON.parse(response.body, symbolize_names: true)
  end

  def mutation_path(name, attributes:, return_types:, headers: nil)
    attributes = GraphqlUtils.hash_to_gql(attributes) if attributes.is_a?(Hash)

    query = <<~GQL
        mutation {
        #{name}(
          input: { attributes: #{attributes} })
          #{return_types}
      }
    GQL

    GraphqlUtils.validate!(query.to_s)

    graphql_request(params: { query: query }, headers: headers)
  end

  def graphql_request(params:, headers: nil)
    post(graphql_path, params: params, headers: headers)
  end
end
