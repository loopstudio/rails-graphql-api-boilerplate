module QueryAnalyzers
  class QueryDepthAnalyzer < GraphQL::Analysis::AST::QueryDepth
    include Concerns::Introspectable

    MAX_DEPTH = ENV.fetch('MAX_DEPTH', 5).to_i

    def result
      return verify_introspection_availability if introspection?

      @depth = super
      max_depth_exceeded_error if depth_exceeded?
    end

    private

    def max_depth_exceeded_error
      GraphQL::AnalysisError.new(
        I18n.t('errors.max_depth_exceeded', current_depth: @depth, max_depth: MAX_DEPTH)
      )
    end

    def depth_exceeded?
      MAX_DEPTH < @depth
    end
  end
end
