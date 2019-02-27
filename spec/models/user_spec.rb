require 'rails_helper'

describe User do
  it { is_expected.to respond_to(:username) }
  it { is_expected.to respond_to(:password_digest) }
  it { is_expected.to respond_to(:sms_number) }
  it { is_expected.to respond_to(:settings) }
  it { is_expected.to respond_to(:zip_code) }
  it { is_expected.to respond_to(:notify_of_frost_warning) }
  it { is_expected.to respond_to(:sms_sent_at) }
  it { is_expected.to respond_to(:sms_verification_code) }

  describe 'creating a user' do
    subject { User.create(user_create_params) }

    context 'creating a new user with a settings hash in JSON format' do
      let(:user_create_params) { {username: username, password: password, settings: settings_hash} }
      let(:username) { 'iamanewuser' }
      let(:password) { 'myawesomepassword' }
      let(:settings_hash) { 
        {
        "zip_code": "12345",
        "notify_of_frost_warning": true
        }
      }

      it 'is valid' do
        expect(subject).to be_valid
      end
    end

    context 'without a username' do
      let(:user_create_params) { {username: username, password: password} }
      let(:username) { nil }
      let(:password) { 'myawesomepassword' }

      it 'is invalid' do
        expect(subject).not_to be_valid
      end
    end

    context 'without a password' do
      let(:user_create_params) { {username: username, password: password} }
      let(:username) { 'iamanewuser' }
      let(:password) { nil }

      it 'is invalid' do
        expect(subject).not_to be_valid
      end
    end
  end
end