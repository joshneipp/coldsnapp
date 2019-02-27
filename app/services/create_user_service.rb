<<-TODO
put this in a users dir under app/services
rails is not autoloading this right now.... sadface 
need to find out why
TODO

class CreateUserService
  class UserCreateError < RuntimeError; end

  def initialize(settings)
    @settings = settings
  end

  def run
    if User.create!(@settings)
      Rails.logger.debug "#{Time.zone.now} -- New user created"
    else
      raise UserCreateError
    end
  end
end