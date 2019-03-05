require 'twilio-ruby'

class TwilioService

  def initialize
    @sms_client = Twilio::REST::Client.new(
      ENV.fetch("TWILIO_ACCOUNT_SID"),
      ENV.fetch("TWILIO_AUTH_TOKEN"),
    )
  end

  def send_message(from:, to:, body:)
    @sms_client.messages.create(from: from, to: to, body: body)
  end

  def message_list
    @sms_client.api.account.messages.list
  end

  def most_recent_message
    message_list.first
  end
end