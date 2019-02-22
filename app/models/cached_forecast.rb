class CachedForecast < ApplicationRecord
    EXPIRATION_INTERVAL = 1.day
    serialize :low_temperatures

    def expired?
        created_at <= Time.zone.now - EXPIRATION_INTERVAL
    end
end
