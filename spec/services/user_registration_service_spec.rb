require 'rails_helper'

describe UserRegistrationService do
  describe '.run' do
    subject { UserRegistrationService.new(new_user).run }
    let(:new_user) { User.new(user_params) }
    let(:existing_user) { User.create!(username: Faker::Internet.username, password: Faker::Internet.password) }
    let(:user_params) do
      {
        username: Faker::Internet.username,
        password: Faker::Internet.password,
        sms_number: ENV.fetch('TWILIO_TEST_SMS_TO'),
        sms_verification_sent_at: nil,
        sms_verification_code: nil,
        settings: {
          "zip_code": "12345"
        }
      }
    end

    context 'with valid params' do

      it 'creates a new user' do
        stub_twilio_request
        expect { subject }.to change { User.count }.by(+1)
      end

      it 'creates a new sms_verification_code for the user' do
        stub_twilio_request
        expect { subject }.to change { new_user.sms_verification_code }.from(nil)
      end

      it 'creates a new next_forecast_check_time for the user' do
        stub_twilio_request
        expect { subject }.to change { new_user.next_forecast_check_time }.from(nil)
      end

      it 'creates a new sms_verification_code that is six characters long' do
        stub_twilio_request
        subject
        expect(new_user.sms_verification_code.length).to eq(6)
      end

      it 'creates a new user that is not sms_verified' do
        stub_twilio_request
        subject
        expect(new_user).not_to be_sms_verified
      end

      it 'sends an sms to the new user' do
        stub_twilio_request
        expect_any_instance_of(TwilioService).to receive(:send_message)
        subject
      end
    end

    context 'when the username already exists' do
      let(:user_params) do
        {
          username: existing_user.username,
          password: existing_user.password,
          sms_number: ENV.fetch('TWILIO_TEST_SMS_TO'),
          sms_verification_sent_at: nil,
          sms_verification_code: nil,
          settings: {
            "zip_code": "12345"
          }
        }
      end

      it 'returns an error' do
        expect do
          subject
        end.to raise_error('Username has already been taken')
      end
    end
  end
end

# TODO extract this into a helper
def stub_twilio_request
  allow_any_instance_of(TwilioService).to receive(:send_message)
end