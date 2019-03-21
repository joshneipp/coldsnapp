class UserForecastWorker
  include Sidekiq::Worker

  # TODO: refactor this method, for length and clarity
  def perform
    Rails.logger.info "#{Time.zone.now} -- Running #{self.class.to_s}"
    users_for_forecast = User.where('next_forecast_check_time <= ?', Time.now)

    Rails.logger.info "#{self.class.to_s}... " "No users to forecast and update" if users_for_forecast.empty?
    return if users_for_forecast.empty?

    users_for_forecast.each do |user|
      if user.settings['notify_of_frost']
        zip_code = user.settings['zip_code']
        forecast = ForecastCacheService.new(zip_code).run
        if forecast && forecast.any? { |day| day < 32 }
          user_message_params = {
            from: ENV['TWILIO_TEST_SMS_FROM'],
            to: user.sms_number,
            # TODO: way better message needed!
            body: 'There is a forecast of frost in your area in the next 7 days. This is a test from user_forecast_worker.rb'
          }
          TwilioService.new.send_message(user_message_params)
        end
        Rails.logger.debug "#{Time.zone.now} -- #{self.class.to_s} -- Fetching forecast for #{user.id}"
      end
    end
    users_for_forecast.update_all(next_forecast_check_time: (Time.now + 1.day))
    Rails.logger.debug "#{Time.zone.now} -- #{self.class.to_s} -- Updating user with ids #{users_for_forecast.pluck(:id)}"
  end
end