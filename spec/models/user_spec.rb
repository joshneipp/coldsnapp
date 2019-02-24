require 'rails_helper'

describe User do

  it { is_expected.to respond_to(:zip_code) }
  it { is_expected.to respond_to(:notify_of_frost_warning) }

  context 'creating a new user with a settings hash in JSON format' do

    subject { User.create({"settings": settings_hash}) }
    let(:settings_hash) { {
      "zip_code": "12345",
      "notify_of_frost_warning": true
    } }

    it 'is valid' do
      expect(subject).to be_valid
    end
  end
end