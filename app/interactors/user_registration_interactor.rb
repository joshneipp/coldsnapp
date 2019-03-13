class UserRegistrationInteractor < ActiveInteraction::Base

  hash :user do
    string :username
    string :password
    string :sms_number, default: nil
    date_time :sms_sent_at, default: nil
    string :sms_verification_code, default: nil
    hash :settings do
      string :zip_code
    end
  end

  validates_with UserRegistration::UsernameValidator
  validates_with UserRegistration::PasswordValidator
  validates_with UserRegistration::PhoneNumberValidator
  validates_with UserRegistration::ZipCodeValidator

  def execute
    begin
      username = user[:username]
      password = user[:password]
      sms_number = user[:sms_number]
      settings = user[:settings]
      user = User.new(username: username, password: password, sms_number: sms_number, settings: settings)
      response = UserRegistrationService.new(user).run
    rescue UserRegistrationService::UserRegistrationError => error
      errors.add(:base, error.message)
    end
  end
end