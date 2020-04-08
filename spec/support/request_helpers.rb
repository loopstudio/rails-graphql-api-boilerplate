module RequestHelpers
  def json
    raise 'Response is nil. Are you sure you made a request?' unless response

    JSON.parse(response.body, symbolize_names: true)
  end

  def auth_headers
    @auth_headers ||= user.create_new_auth_token
  end

  def mutation_path(name, attributes:, return_types:, headers: nil)
    mutation_params = {
      query:
        <<~GQL
            mutation {
            #{name}(
              input: { attributes: #{attributes} })
              #{return_types}
          }
        GQL
    }

    graphql_request(params: mutation_params, headers: headers)
  end

  def graphql_request(params:, headers: nil)
    post graphql_path, params: params, headers: headers
  end
end
