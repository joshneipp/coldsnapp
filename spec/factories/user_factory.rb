FactoryBot.define do
  factory :user do
    username { Faker::Internet.username }
    password { Faker::Internet.password }
    sms_number { ENV['TWILIO_SMS_TO'] }
    sms_verification_code { nil }
    sms_verification_sent_at { nil }

    trait :forecast_due do
      next_forecast_check_time { Time.now }
    end

    trait :notify_of_frost do
      settings {
        {
          "notify_of_frost": true,
          "zip_code": "12345"
        }
      }
    end
    
    factory :unverified_user do
      sms_verified { false }
    end

    factory :forecast_due_user do
      after :save do |user|
        user.update_attributes!(next_forecast_check_time:  Time.now)
      end
    end
  end
end