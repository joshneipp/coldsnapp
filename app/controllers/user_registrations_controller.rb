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
      # TODO: make unique!
      user = User.find_by(username: params[:user][:username])
      log_in(user) if user
      redirect_to controller: 'user_verifications', action: 'new'
      # render json: { status: 200 }
    else
      render json: { error: response.errors.full_messages }, status: 400
    end
  end
end