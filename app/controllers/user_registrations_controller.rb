class UserRegistrationsController < ApplicationController

  def new
    @user_registration = User.new
  end

  def show
    @user_registration = User.find(params[:id])
  end

  def create
    response = UserRegistrationInteractor.run(params)
    if response.valid?
      user = User.find_by(username: params[:user][:username])
      log_in(user) if user
      redirect_to '/verify'
    else
      flash[:notice] = response.errors.full_messages[0]
      redirect_to '/signup'
    end
  end
end