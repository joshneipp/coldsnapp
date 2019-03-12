require 'rails_helper'

describe UserVerificationsController do

  describe '.create' do

    subject { post :create, params: params }
    let(:valid_verification_params) do
      {
        id: 1,
        verification_code: '654321'
      }
    end

    context 'with valid verification code' do
      let(:params) { valid_verification_params }
      it 'is successful' do
        subject
        expect(response.status).to eq(200)
      end
    end
  end
end