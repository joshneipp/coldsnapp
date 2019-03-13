require 'rails_helper'

describe UserVerificationService do

  describe '.run' do

    subject { UserVerificationService.new(params).run }
    let(:valid_params) do
      {
        user_id: user.id,
        verification_code: user.sms_verification_code
      }
    end
    let(:user) { FactoryBot.create(:unverified_user) }
    
    context 'when the verification code matches the user' do
      let(:params) { valid_params }
      it 'changes the user from unverified to verified' do
        expect do
          subject
        end.to change { User.find_by(id: params[:user_id]).sms_verified }.from(false).to(true)
      end
    end

    context 'when the verification code does not match the user' do
      let(:params) { valid_params.merge(verification_code: invalid_code) }
      let(:invalid_code) { '123' }

      it 'raises an error' do
        expect do
          subject
        end.to raise_error(UserVerificationService::VerificationCodeDoesNotMatchError)
      end
    end

    context 'when the user is not found based on the user id' do
      let(:params) { valid_params.merge(user_id: invalid_id) }
      let(:invalid_id) { 999999 }

      it 'raises an error' do
        expect do
          subject
        end.to raise_error(UserVerificationService::UserNotFoundError)
      end
    end
  end
end