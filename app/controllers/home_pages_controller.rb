class HomePagesController < ApplicationController
  def index
    log_current_method(__method__)
    MinuteWorker.perform_async('some_arg')
  end

  def log_current_method(method)
    log_delimiter
    logger.tagged("#{Time.zone.now} -- #{self.class.to_s}") do
      {logger.debug "#{method.to_s}"}
    end
    log_delimiter
  end

  def log_delimiter
    logger.debug '-----####################-----'
  end
end
