module GraphqlRequestResolver
  include ActiveSupport::Concern

  def resolve(query:, context:)
    if _json
      resolve_multiplex(context)
    else
      resolve_execute(query, context)
    end
  end

  private

  def resolve_execute(query, context)
    RailsApiBoilerplateSchema.execute(
      query[:query],
      operation_name: query[:operationName],
      variables: hasherize(query[:variables]),
      context: context
    )
  end

  def resolve_multiplex(context)
    input = _json.map do |query|
      {
        query: query[:query],
        operation_name: query[:operationName],
        variables: hasherize(query[:variables]),
        context: context
      }
    end

    RailsApiBoilerplateSchema.multiplex(input)
  end

  def hasherize(input)
    return {} if input.blank?

    case input
    when String then hasherize(JSON.parse(input))
    when Hash, ActionController::Parameters then input
    else raise ArgumentError, I18n.t('errors.unexpected_param', param: ambiguous_param.to_s)
    end
  end

  def _json
    params[:_json]
  end
end
