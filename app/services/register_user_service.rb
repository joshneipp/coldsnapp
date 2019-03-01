class RegisterUserService
  class RegisterUserError < RuntimeError; end

  def initialize(user)
    @user = user
  end

  def execute
    if @user.save
      @user.update_attributes(sms_verification_code: rand(100000..999999).to_s)
      Rails.logger.debug "#{Time.zone.now}" " -- " "New user registered"
    else
      raise RegisterUserError
    end
  end
end