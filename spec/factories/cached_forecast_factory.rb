FactoryBot.define do
    factory :cached_forecast do
        zip_code { '27278' }

        trait :above_freezing do
            low_temperatures { [33, 34, 35, 36, 37, 38, 39, 40, 41, 42] }
        end
        
        trait :below_freezing do
            low_temperatures { [30, 31, 32, 33, 34, 38, 39, 40, 41, 42] }
        end
    end
end