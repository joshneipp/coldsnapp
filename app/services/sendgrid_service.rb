require 'sendgrid-ruby'
include SendGrid

class SendgridService

  def initialize
    @client = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'], host: 'https://api.sendgrid.com').client
  end

  def run(from, subject, to, content)
    from = Email.new(email: from)
    to = Email.new(email: to)
    content = Content.new(type: 'text/plain', value: content)

    Rails.logger.info "#{Time.zone.now} -- #{self.class.to_s} -- from #{from.inspect}...."
    Rails.logger.info "#{Time.zone.now} -- #{self.class.to_s} -- to #{to.inspect}...."
    Rails.logger.info "#{Time.zone.now} -- #{self.class.to_s} -- content #{content.inspect}...."

    mail = Mail.new(from, subject, to, content)

    Rails.logger.info "#{Time.zone.now} -- #{self.class.to_s} -- mail #{mail.to_json}...."

    @client.mail._('send').post(request_body: mail.to_json)
  end
end