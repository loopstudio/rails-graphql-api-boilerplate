class GraphqlController < ApplicationController
  def execute
    result = if params[:_json]
               GraphqlService.multiplex(params[:_json], context: context)
             else
               GraphqlService.execute(params, context: context)
             end

    render json: result
  end

  private

  def context
    { current_user: current_user }
  end

  def current_user
    authorization_headers = request.headers['Authorization']
    return nil if authorization_headers.blank?

    token = authorization_headers.split(' ').last
    return nil if token.blank?

    AuthToken.verify(token)
  end
end
