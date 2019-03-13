class UserVerificationService
  class UserNotFoundError < StandardError; end
  class VerificationCodeDoesNotMatchError < StandardError; end

  def initialize(verification_code:, user_id:)
    @verification_code = verification_code
    @user = User.find_by(id: user_id)
  end

  def run
    if @user
      if @user.sms_verification_code == @verification_code
        @user.update_attributes(sms_verified: true)
      else
        raise VerificationCodeDoesNotMatchError
      end
    else
      raise UserNotFoundError
    end
  end
end