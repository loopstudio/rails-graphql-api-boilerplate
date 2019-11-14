class GraphqlController < ApplicationController
  def execute
    query = params[:query]
    operation_name = params[:operationName]
    context = {
      current_user: current_user
    }
    result = RailsApiBoilerplateSchema.execute(
      query,
      variables: variables,
      context: context,
      operation_name: operation_name
    )
    render json: result
  rescue StandardError => e
    raise e unless Rails.env.development?

    handle_error_in_development e
  end

  private

  def variables
    ensure_hash(params[:variables])
  end

  def current_user
    authorization_headers = request.headers['Authorization']
    return nil if authorization_headers.blank?

    token = authorization_headers.split(' ').last
    return nil if token.blank?

    AuthToken.verify(token)
  end

  # Handle form data, JSON body, or a blank value
  def ensure_hash(ambiguous_param)
    case ambiguous_param
    when String
      if ambiguous_param.present?
        ensure_hash(JSON.parse(ambiguous_param))
      else
        {}
      end
    when Hash, ActionController::Parameters
      ambiguous_param
    when nil
      {}
    else
      raise ArgumentError, "Unexpected parameter: #{ambiguous_param}"
    end
  end

  def handle_error_in_development(error)
    message = error.message
    backtrace = error.backtrace
    logger.error(message)
    logger.error(backtrace.join("\n"))

    render(
      json: { error: { message: message, backtrace: backtrace }, data: {} },
      status: :internal_server_error
    )
  end
end
