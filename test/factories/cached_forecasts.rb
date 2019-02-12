FactoryBot.define do
  factory :cached_forecast do
    zip_code { "MyString" }
    low_temperatures { "MyText" }
  end
end
