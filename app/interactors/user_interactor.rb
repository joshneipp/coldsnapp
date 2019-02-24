class UserInteractor < ActiveInteraction::Base
  class InvalidZipCodeError < StandardError; end

  hash :settings do
    string :zip_code
  end

  def execute
    raise InvalidZipCodeError unless settings[:zip_code].length == 5
  end
end