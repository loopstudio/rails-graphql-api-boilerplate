class GraphqlChannel < ApplicationCable::Channel
  delegate :subscription?, to: :result

  attr_reader :result

  def subscribed
    @subscription_ids = []
  end

  def execute(data)
    context = { channel: self }

    set_result(data, context)

    payload = {
      result: subscription? ? { data: nil } : result.to_h,
      more: subscription?
    }

    # Track the subscription here so we can remove it on unsubscribe.
    @subscription_ids << context[:subscription_id] if result.context[:subscription_id]

    transmit(payload)
  end

  def unsubscribed
    @subscription_ids.each do |sid|
      RailsApiBoilerplateSchema.subscriptions.delete_subscription(sid)
    end
  end

  private

  def set_result(data, context)
    query, operation_name = data.values_at('query', 'operationName')
    variables = ensure_hash(data['variables'])

    @result = RailsApiBoilerplateSchema.execute(
      query: query,
      context: context,
      variables: variables,
      operation_name: operation_name
    )
  end

  def ensure_hash(ambiguous_param)
    case ambiguous_param
    when String
      ambiguous_param.present? ? ensure_hash(JSON.parse(ambiguous_param)) : {}
    when Hash, ActionController::Parameters
      ambiguous_param
    when nil
      {}
    else
      raise ArgumentError, I18n.t('errors.unexpected_param', param: ambiguous_param.to_s)
    end
  end
end
