FactoryBot.define do
  factory :user do
    username { Faker::Internet.username }
    password { Faker::Internet.password }
    sms_number { Faker::PhoneNumber.cell_phone }
    sms_verification_code { nil }
    sms_verification_sent_at { nil }
    
    factory :unverified_user do
      sms_verified { false }
    end
  end
end