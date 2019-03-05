class UserRegistrationsController < ApplicationController

  def create
    response = UserRegistrationInteractor.run(params)
    if response.valid?
      render json: { status: 200 }
    else
      render json: { error: outcome.errors.full_messages.to_sentence }
    end
  end
end