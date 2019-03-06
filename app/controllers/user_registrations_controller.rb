class UserRegistrationsController < ApplicationController

  def new
    @user_registration = User.new
  end

  def show
    @user_registration = User.find(params[:id])
  end

  def create
    @user_registration = User.new(params[:user])
    response = UserRegistrationInteractor.run(params)
    if response.valid?
      render json: { status: 200 }
    else
      render json: { error: response.errors.full_messages.to_sentence }
    end
  end
end