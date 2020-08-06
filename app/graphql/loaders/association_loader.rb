module Loaders
  class AssociationLoader < GraphQL::Batch::Loader
    def self.validate(model, association_name)
      new(model, association_name)
      nil
    end

    def initialize(model, association_name)
      super
      @model = model
      @association_name = association_name
      validate
    end

    def load(record)
      unless record.is_a?(@model)
        raise TypeError, I18n.t('errors.association_error', model: @model,
                                                            class: record.class.model_name.human)
      end
      return Promise.resolve(read_association(record)) if association_loaded?(record)

      super
    end

    # We want to load the associations on all records, even if they have the same id
    def cache_key(record)
      record.object_id
    end

    def perform(records)
      preload_association(records)
      records.each { |record| fulfill(record, read_association(record)) }
    end

    private

    def validate
      return if @model.reflect_on_association(@association_name)

      raise ArgumentError, I18n.t(
        'errors.association_not_found', model: @model, association: @association_name
      )
    end

    def preload_association(records)
      ::ActiveRecord::Associations::Preloader.new.preload(records, @association_name)
    end

    def read_association(record)
      record.public_send(@association_name)
    end

    def association_loaded?(record)
      record.association(@association_name).loaded?
    end
  end
end
