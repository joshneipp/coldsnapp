require 'rails_helper'

describe SmsVerificationService do
  context 'success' do
    subject { SmsVerificationService.new(params).verify }
    let(:params) {
      {
        id: user.id,
        sms_verification_code: user.sms_verification_code
      }
    }
    let(:user) { FactoryBot.create(:user, :unverified) }

    it 'is successful when the verification in params matches the users verification code' do
      expect { subject }.to change { user.reload.sms_verified }.from(false).to(true)
    end
  end

  context 'failure' do
    it 'is unsuccessful when the verification code in params does not matche the users verification code' do
    end
  end
end