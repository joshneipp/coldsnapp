class User < ApplicationRecord
  # settings is a JSON hash with keys such as "zip_code"
  # store_accessor allows us accessor methods on the keys within "settings"
  store_accessor :settings, :zip_code, :notify_of_frost_warning
  has_secure_password
  validates :username, presence: true, uniqueness: true
  validates :sms_number, uniqueness: true
  before_create :set_next_forecast_check_time
  before_create :set_sms_verification_code

  def set_next_forecast_check_time
    self.next_forecast_check_time = RandomTimeService.random_minute_in_the_morning
  end

  def set_sms_verification_code
    self.sms_verification_code = rand(100000..999999).to_s
  end
end
