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

  def graphql_request(request, variables: {}, headers: nil)
    GraphqlUtils.validate!(request.to_s)

    post(graphql_path, params: { query: request, variables: variables }, headers: headers)
  end
end
