require 'twilio-ruby'

class TwilioService

  def initialize(user_id = nil)
    @client = Twilio::REST::Client.new(
      ENV.fetch("TWILIO_ACCOUNT_SID"),
      ENV.fetch("TWILIO_AUTH_TOKEN"),
    )
    @user_id = user_id
  end

  def send_message(from:, to:, body:)
    @client.messages.create(from: from, to: to, body: body)
  end

  def message_list
    @client.api.account.messages.list
  end

  def most_recent_message
    message_list.first
  end
end