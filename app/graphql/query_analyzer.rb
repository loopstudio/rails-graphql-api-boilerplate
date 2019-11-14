class QueryAnalyzer
  def analyze?(query)
    return false if query.blank?
    return false if query.selected_operation_name == 'IntrospectionQuery'

    true
  end

  # Called before the visit.
  # Returns the initial value for `memo`
  def initial_value(query)
    query.selected_operation.selections.map(&:name)
  end

  # This is like the `reduce` callback.
  # The return value is passed to the next call as `memo`
  def call(memo, visit_type, irep_node)
    memo << irep_node.name if visit_type == :enter
    memo
  end

  # Called when we're done the whole visit.
  # The return value may be a GraphQL::AnalysisError (or an array of them).
  # Or, you can use this hook to write to a log, etc
  def final_value(memo)
    memo.uniq.each do |field|
      Event.create!(field_name: field) if field.present?
    end
  end
end
