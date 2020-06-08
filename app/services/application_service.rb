class ApplicationService
  attr_reader :result

  class << self
    def call(*args, &block)
      service = new(*args, &block)
      service.call
      service
    end
  end

  def call; end

  def success?
    errors.empty?
  end

  def errors
    @errors ||= []
  end
end
