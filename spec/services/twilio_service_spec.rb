require 'rails_helper'

describe TwilioService do

  describe '#send_message' do
    let(:client) { TwilioService.new }
    subject { client.send_message(message_params)}
    let(:message_params) {
      {
        from: ENV['TWILIO_TEST_SMS_FROM'],
        to: ENV['TWILIO_TEST_SMS_TO'],
        body: 'This is a test from twilio_service_spec.rb'
      }
    }
    it 'sends a message' do
      expect { subject }.to change { client.message_list.size }.by(+1)
    end

    it 'sends a message with the correct body' do
      subject
      expect(client.most_recent_message.body).to include(message_params[:body])
    end

    it 'sends a message to the correct recipient' do
      subject
      expect(client.most_recent_message.to).to eq(message_params[:to])
    end
  end
end