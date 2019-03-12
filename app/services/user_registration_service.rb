class UserRegistrationService
  class UserRegistrationError < RuntimeError; end

  def initialize(user)
    @user = user
  end

  def run
    if @user.save
      send_sms_verification
      Rails.logger.debug "#{Time.zone.now}" " -- " "New user registered"
    else
      # TODO handle error for interactor
      raise UserRegistrationError
      # return 
    end
  end

  def send_sms_verification
    TwilioService.new.send_message(sms_verification_params)
  end

  def sms_verification_params
    {
      from: ENV.fetch('TWILIO_SMS_FROM'),
      to: @user.sms_number,
      body: sms_verification_message_body
    }
  end

  def sms_verification_message_body
    "Your verification code is " "#{@user.sms_verification_code}"
  end
end