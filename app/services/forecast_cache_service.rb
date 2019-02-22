class ForecastCacheService

  class NullForecast < RuntimeError; end
  class ExpiredForecast < RuntimeError; end

  def initialize(zip_code)
    @zip_code = zip_code
  end

  def run
    forecast = CachedForecast.find_by(zip_code: @zip_code)
    forecast = fetch_new_forecast if forecast.nil? || forecast.expired?
    forecast
  end

  def fetch_new_forecast
    low_temperatures = WeatherClientService.new(@zip_code).low_temperatures
    CachedForecast.create(zip_code: @zip_code, low_temperatures: low_temperatures)
  end
end

