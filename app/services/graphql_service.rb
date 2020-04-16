module GraphqlService
  module_function

  def execute(query, context:)
    RailsApiBoilerplateSchema.execute(
      query[:query],
      operation_name: query[:operationName],
      variables: hasherize(query[:variables]),
      context: context
    )
  end

  def multiplex(queries, context:)
    input = queries.map do |query|
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

  private_class_method :hasherize
end
