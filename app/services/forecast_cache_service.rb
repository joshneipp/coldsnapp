class ForecastCacheService

  def initialize(zip_code)
    @zip_code = zip_code
  end

  def run
    forecast = CachedForecast.find_by(zip_code: @zip_code)
    Rails.logger.info "Forecast: " "#{forecast.inspect}"
    
    forecast = fetch_new_forecast if forecast.nil? || forecast.expired?
    Rails.logger.info "Forecast: " "#{forecast.inspect}"
    forecast
  end

  def fetch_new_forecast
    low_temperatures = WeatherClientService.new(@zip_code).low_temps
    CachedForecast.create(zip_code: @zip_code, low_temperatures: low_temperatures)
    low_temperatures
  end
end