class GraphqlController < ApplicationController
  include GraphqlResolver

  def execute
    result = resolve(_json, params, context)

    render json: result
  end

  private

  def context
    { current_user: current_user }
  end

  def _json
    params[:_json]
  end
end
