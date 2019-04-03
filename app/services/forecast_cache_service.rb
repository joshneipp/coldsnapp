class ForecastCacheService

  def initialize(zip_code)
    @zip_code = zip_code
  end

  def run
    Rails.logger.info "Running forecast cache service"
    forecast = CachedForecast.find_by(zip_code: @zip_code)
    Rails.logger.info "Forecast: " "#{forecast.inspect}"
    if forecast.nil? || forecast.expired?
      Rails.logger.info "New forecast needed"
      forecast = fetch_new_forecast
    else
      Rails.logger.info "Cached forecast exists"
      forecast = forecast.low_temperatures
    end
    forecast
  end

  def fetch_new_forecast
    low_temperatures = WeatherClientService.new(@zip_code).low_summary_to_s
    CachedForecast.create(zip_code: @zip_code, low_temperatures: low_temperatures)
    low_temperatures
  end
end