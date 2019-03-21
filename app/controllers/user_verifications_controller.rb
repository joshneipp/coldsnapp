class UserVerificationsController < ApplicationController
  include UserRegistrationsHelper
  def new
  end

  def create
    @user = User.find_by(id: session[:user_id])
    params[:session] = session.to_h
    params[:session][:user_id] = session[:user_id]

    # params[:session] = session.to_hash
    response = UserVerificationsInteractor.run(params)
    if response.valid?
      render json: { status: 200 }
    else
      render json: { error: response.errors.full_messages }, status: 400
    end
  end
end
