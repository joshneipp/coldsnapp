class CachedForecast < ApplicationRecord
    serialize :low_temperatures

    def expired?
        created_at <= Time.zone.now - 1.day
    end
end
