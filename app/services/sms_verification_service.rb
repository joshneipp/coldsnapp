class SmsVerificationService

  def initialize(params)
    @id = params.fetch(:id)
    @verification_code = params.fetch(:sms_verification_code)
  end

  def run
    user = User.find(@id)
    user.update_attributes(sms_verified: true) if matching_verification_code?(user)
  end

  private

  def matching_verification_code?(user)
    user.sms_verification_code == @verification_code
  end
end