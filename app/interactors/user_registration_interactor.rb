class UserRegistrationInteractor < ActiveInteraction::Base
  class InvalidZipCodeError < StandardError; end

  string :username
  string :password
  string :sms_number, default: nil
  date_time :sms_sent_at, default: nil
  string :sms_verification_code, default: nil
  hash :settings do
    string :zip_code
  end

  def execute
    raise InvalidZipCodeError unless zip_code_length_five?(settings[:zip_code])
    user = User.new(username: username, password: password, sms_number: sms_number, settings: {})
    UserRegistrationService.new(User.new).execute
  end

  private 

  def zip_code_length_five?(zip_code)
    zip_code.length == 5 && zip_code.to_i.to_s.length == 5
  end
end