class UserVerificationsInteractor < ActiveInteraction::Base
  
  string :verification_code
  hash :session do
    integer :user_id
  end

  def execute
    begin
      response = UserVerificationService.new(verification_code: verification_code, user_id: session[:user_id]).run

    rescue UserVerificationService::UserNotFoundError
      errors.add(:base, I18n.t(:user_not_found))
    rescue UserVerificationService::VerificationCodeDoesNotMatchError
      errors.add(:base, I18n.t(:invalid_verification_code))
    end
  end
end