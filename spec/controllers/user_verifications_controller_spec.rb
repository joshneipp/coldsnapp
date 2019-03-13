require 'rails_helper'

describe UserVerificationsController do

  describe '.create' do

    subject { post :create, params: params, session: valid_session }
    let(:user) { FactoryBot.create(:unverified_user) }
    let(:valid_verification_params) do
      {
        verification_code: user.sms_verification_code,
        session: {
          user_id: user.id
        }
      }
    end
    let(:valid_session) { { user_id: user.id } }

    context 'with a valid verification code' do
      let(:params) { valid_verification_params }
      it 'is successful' do
        subject
        expect(response.status).to eq(200)
      end

      it 'changes a user from unverified to verified' do
        expect do
          subject
        end.to change { User.find_by(id: params[:session][:user_id]).sms_verified }.from(false).to(true)
      end
    end

    context 'with a verification code that does not match the user' do
      let(:params) { valid_verification_params.merge(verification_code: invalid_code) }
      let(:invalid_code) { '123' }
      it 'is unsuccessful' do
        subject
        expect(response.status).to eq(400)
      end

      it 'returns an error about the incorrect verification code' do
        subject
        json_response = JSON.parse(response.body)
        expect(json_response['error']).to include('Verification code does not match')
      end
    end

    context 'with a user id that does not match the user' do
      subject { post :create, params: params, session: invalid_session }

      let(:invalid_session) { { user_id: invalid_id } }
      let(:params) { valid_verification_params }
      let(:invalid_id) { 999999 }
      it 'is unsuccessful' do
        subject
        expect(response.status).to eq(400)
      end

      it 'returns an error about the incorrect user' do
        subject
        json_response = JSON.parse(response.body)
        expect(json_response['error']).to include('User not found')
      end
    end
  end
end