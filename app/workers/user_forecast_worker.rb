class UserForecastWorker
  include Sidekiq::Worker

  def perform
    Rails.logger.debug "Running UserForecastWorker"
    puts "Running UserForecastWorker"
  end
end