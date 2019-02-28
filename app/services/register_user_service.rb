class RegisterUserService
  class RegisterUserError < RuntimeError; end

  def initialize(user)
    @user = user
  end

  def execute
    if @user.save
      Rails.logger.debug "#{Time.zone.now}" " -- " "New user registered"
    else
      raise RegisterUserError
    end
  end
end