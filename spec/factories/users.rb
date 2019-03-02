FactoryBot.define do
  factory :user do
    username { 'username' }
    password { 'password1' }
    sms_number { '11231231234' }
    sms_verification_code { '123123' }
    sms_verification_sent_at { nil }
    
    factory :unverified_user do
      sms_verified { false }
    end
  end
end