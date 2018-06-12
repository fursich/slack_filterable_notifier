module ExceptionNotifier
  class SlackFilterableNotifier < SlackNotifier
    include ExceptionNotifier::BacktraceCleaner

    attr_accessor :notifier
    attr_accessor :ignored_exceptions_for_slack # uniquely with slack notifier

    def initialize(options)
      super
      @ignored_exceptions_for_slack = options[:ignored_exception]
    end

    def call(exception, options={})
      return false if ignored_exceptions_for_slack?(exception)
      super
    end

    protected

    def ignored_exceptions_for_slack?(exception)
      ignored_exceptions  = Array(ignored_exceptions_for_slack).map(&:to_s)
      exception_ancestors = exception.class.ancestors.map(&:to_s)
      !(ignored_exceptions & exception_ancestors).empty?
    end
  end
end
