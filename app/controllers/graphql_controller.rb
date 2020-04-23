class GraphqlController < ApplicationController
  def execute
    result = if _json
               GraphqlService.multiplex(_json, context: context)
             else
               GraphqlService.execute(params, context: context)
             end

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
