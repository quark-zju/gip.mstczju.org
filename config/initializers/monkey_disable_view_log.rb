module ActionView
  class LogSubscriber < ActiveSupport::LogSubscriber
    def logger
      @@nil_logger ||= Logger.new(nil)
    end
  end
end
