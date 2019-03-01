require 'rails_helper'

describe RegisterUserService do
  describe '.create_user' do
    subject { RegisterUserService.new(new_user).execute }
    let(:new_user) { User.new(user_params) }

    context 'valid params' do
      let(:user_params) do
        {
          username: 'myusername',
          password: 'mypassword',
          sms_number: '+11231231234',
          sms_verification_sent_at: nil,
          sms_verification_code: nil,
          settings: {
            "zip_code": "12345"
          }
        }
      end

      it 'creates a new user' do
        expect { subject }.to change { User.count }.by(+1)
      end

      it 'creates a new sms_verification_code for the user' do
        expect { subject }.to change { new_user.sms_verification_code }.from(nil)
      end

      it 'creates a new sms_verification_code that is six characters long' do
        subject
        expect(new_user.sms_verification_code.length).to eq(6)
      end

      it 'creates a new user that is not sms_verified' do
        subject
        expect(new_user).not_to be_sms_verified
      end
    end
  end
end