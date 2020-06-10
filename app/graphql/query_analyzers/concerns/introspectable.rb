module QueryAnalyzers
  module Concerns
    module Introspectable
      extend ActiveSupport::Concern

      private

      def verify_introspection_availability
        introspection_not_available_error unless insights_enabled?
      end

      def introspection?
        query.operation_name == 'IntrospectionQuery'
      end

      def introspection_not_available_error
        GraphQL::AnalysisError.new(I18n.t('errors.instrospection_not_available'))
      end

      def insights_enabled?
        GraphqlConfig::EXPOSE_API_INSIGHTS
      end
    end
  end
end
