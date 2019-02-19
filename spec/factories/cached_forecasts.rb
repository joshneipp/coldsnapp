FactoryBot.define do
    factory :cached_forecast do
        zip_code { "12345" }

        trait :above_freezing do
            low_temperatures { [33, 34, 35, 36, 37, 38, 42, 40, 41, 39] }
        end
        
        trait :below_freezing do
            low_temperatures { [33, 28, 35, 36, 37, 38, 42, 40, 41, 39] }
        end

        trait :expired do
            created_at { Time.zone.now - 1.day }
        end
        
        trait :not_expired do
            low_temperatures { [33, 28, 35, 36, 37, 38, 42, 40, 41, 39] }
            created_at { Time.zone.now }
        end

    end
end