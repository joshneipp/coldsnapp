require 'rails_helper'

describe UserRegistrationsController do

  describe '.create' do

    subject { post :create, params: params }
    let(:params) {
      {
        username: Faker::Internet.username,
        password: Faker::Internet.password,
        sms_number: ENV.fetch('TWILIO_TEST_SMS_TO'),
        settings: {
          zip_code: '12345'
        }
      }
    }

    it 'is successful' do
      stub_twilio_request
      subject
      expect(response.status).to eq(200)
    end

    it 'creates a new user' do
      stub_twilio_request
      expect { subject }.to change { User.count }.by(+1)
    end

    it 'sends an sms message to the new user' do
      stub_twilio_request
      expect_any_instance_of(TwilioService).to receive(:send_message)
      subject
    end
  end
end

# TODO extract this into a helper
def stub_twilio_request
  allow_any_instance_of(TwilioService).to receive(:send_message)
end
