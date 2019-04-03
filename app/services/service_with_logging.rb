class ServiceWithLogging

  def initialize
    Rails.logger.info("Running " "#{self.class.to_s}")
  end
end