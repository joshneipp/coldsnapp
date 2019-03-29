class UserForecastWorker
  include Sidekiq::Worker

  # TODO: refactor this method, for length and clarity
  def perform
    log_current_worker
    log_no_users_for_forecast if users_for_forecast.empty?

    forecast_and_notify_users(users_for_forecast) unless users_for_forecast.empty?
  end

  def forecast_and_notify_users(users_for_forecast)
    users_for_forecast.each do |user|
      if user.settings['notify_of_frost']
        zip_code = user.settings['zip_code']
        log_weather_forecast_activity(user.id)
        forecast = ForecastCacheService.new(zip_code).run
        log_forecast_failure(zip_code) unless forecast
        if forecast && forecast.any? { |day| day < 32 }
          log_twilio_activity(user.id)
          send_sms_message(user.sms_number)
        else
          log_no_forecast_for_user(user.id)
        end
        Rails.logger.debug "#{Time.zone.now} -- #{self.class.to_s} -- Updating user with ids #{users_for_forecast.pluck(:id)}"
        users_for_forecast.update_all(next_forecast_check_time: (Time.now + 1.day))
      end
    end
  end

  private

  def log_current_worker
    Rails.logger.info "#{Time.zone.now} -- Running #{self.class.to_s}...."
  end

  def users_for_forecast
    @users_for_forecast ||= User.where('next_forecast_check_time <= ?', Time.now)
  end

  def log_no_users_for_forecast
    Rails.logger.info "#{Time.zone.now} -- #{self.class.to_s} -- No users to forecast and update...."
  end

  def log_weather_forecast_activity(user_id)
    Rails.logger.info "#{Time.zone.now} -- #{self.class.to_s} -- Fetching forecast for #{user_id}...."
  end

  def log_forecast_failure(zip_code)
    Rails.logger.info "#{Time.zone.now} -- #{self.class.to_s} -- Forecast failed for zip code #{zip_code}...."
  end

  def log_twilio_activity(user_id)
    Rails.logger.info "#{Time.zone.now} -- #{self.class.to_s} -- Twilio: " "sending a message for user with id #{user_id}...."
  end

  def log_no_forecast_for_user(user_id)
    Rails.logger.info "#{Time.zone.now} -- #{self.class.to_s} -- No frost forecast for user with id #{user_id}"
  end

  def send_sms_message(user)
    TwilioService.new.send_message(message_params_for(user))
  end

  def message_params_for(sms_number)
    {
      from: ENV['TWILIO_TEST_SMS_FROM'],
      to: sms_number,
      body: 'There is a forecast of frost in your area in the next 7 days.'
    }
  end
end