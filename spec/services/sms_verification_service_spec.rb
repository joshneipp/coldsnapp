require 'rails_helper'

describe SmsVerificationService do
  subject { SmsVerificationService.new(params).verify }
  let(:user) { FactoryBot.create(:unverified_user) }
  context 'success' do
    let(:params) {
      {
        id: user.id,
        sms_verification_code: user.sms_verification_code
      }
    }

    it 'is successful when the verification in params matches the users verification code' do
    expect { subject }.to change { user.reload.sms_verified }.from(false).to(true)
    end
  end
  
  context 'failure' do
    let(:params) {
      {
        id: user.id,
        sms_verification_code: 'invalidcode'
      }
    }
    it 'is unsuccessful when the verification in params does not match the users verification code' do
      expect { subject }.not_to change { user.reload.sms_verified }
    end
  end
end