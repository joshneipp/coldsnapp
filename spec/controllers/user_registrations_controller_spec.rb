require 'rails_helper'

describe UserRegistrationsController do

  describe '.create' do

    subject { post :create, params: params }
    let(:params) {
      {
        username: Faker::Internet.username,
        password: Faker::Internet.password,
        settings: {
          zip_code: Faker::Address.zip_code
        }
      }
    }

    it 'is successful' do
      subject
      expect(response.status).to eq(200)
    end

    it 'creates a new user' do
      expect { subject }.to change { User.count }.by(+1)
    end
  end
end