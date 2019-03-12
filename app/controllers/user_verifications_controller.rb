class UserVerificationsController < ApplicationController
  def new
  end

  def create
    response = UserVerificationsInteractor.run(params)
  end
end
