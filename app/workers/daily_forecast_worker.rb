class DailyForecastWorker
  include Sidekiq::Worker

  def perform
    Rails.logger.info "#{Time.zone.now} -- #{self.class.to_s}...."

    daily_forecast_users = User.where("settings ->> 'send_daily_forecast' = 'true'")

    Rails.logger.info "#{Time.zone.now} -- #{self.class.to_s} -- daily_forecast_users #{daily_forecast_users}...."

    return if daily_forecast_users.empty?
    daily_forecast_users.each do |user|
      zip_code = user.settings['zip_code']
      log_weather_forecast_activity(user.id)
      forecast = ForecastCacheService.new(zip_code).run

      Rails.logger.info "#{Time.zone.now} -- #{self.class.to_s} -- forecast #{forecast.inspect}...."

      from = ENV.fetch('SENDGRID_TEST_FROM')
      subject = 'Your daily coldsnapp forecast'
      to = ENV.fetch('SENDGRID_TEST_TO')
      content = forecast.to_s
      res = SendgridService.new.run(from, subject, to, content)
      res.status_code

      Rails.logger.info "#{Time.zone.now} -- #{self.class.to_s} -- status_code #{res.status_code}...."
      Rails.logger.info "#{Time.zone.now} -- #{self.class.to_s} -- status_code #{res.inspect}...."

    end
  end

  def log_weather_forecast_activity(user_id)
    Rails.logger.info "#{Time.zone.now} -- #{self.class.to_s} -- Fetching forecast for #{user_id}...."
  end
end
