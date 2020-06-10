module QueryAnalyzers
  class QueryComplexityAnalyzer < GraphQL::Analysis::AST::QueryComplexity
    include Concerns::Introspectable

    MAX_COMPLEXITY = ENV.fetch('MAX_COMPLEXITY', 30).to_i

    def result
      return verify_introspection_availability if introspection?

      @complexity = super
      max_complexity_exceeded_error if complexity_exceeded?
    end

    private

    def max_complexity_exceeded_error
      GraphQL::AnalysisError.new(
        I18n.t(
          'errors.max_complexity_exceeded',
          current_complexity: @complexity,
          max_complexity: MAX_COMPLEXITY
        )
      )
    end

    def complexity_exceeded?
      MAX_COMPLEXITY < @complexity
    end
  end
end
