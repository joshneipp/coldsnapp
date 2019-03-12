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
      render json: { status: 200 }
    else
      render json: { error: response.errors.full_messages }, status: 400
    end
  end
end