require 'rails_helper'

describe RegisterUserService do
  describe '.create_user' do
    subject { RegisterUserService.new(User.new(user_params)).execute }

    context 'valid params' do
      let(:user_params) do
        {
          username: 'myusername',
          password: 'mypassword',
          sms_number: '+11231231234',
          sms_sent_at: nil,
          sms_verification_code: nil,
          settings: {
            "zip_code": "12345"
          }
        }
      end

      it 'creates a new user' do
        expect { subject }.to change { User.count }.by(+1)
      end

      xit 'creates a new sms_verification_code for the user' do

      end
    end
  end
end