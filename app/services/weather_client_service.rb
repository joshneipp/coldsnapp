require 'open_weather'
require 'net/http'
require 'json'

class WeatherClientService
  CONFIG = {
    units: 'imperial',
    appid: ENV["OPEN_WEATHER_API_KEY"]
  }
  URL_STRING = 'http://api.openweathermap.org/data/2.5/forecast/daily'

  def initialize(zip_code)
    @zip_code = zip_code
    Rails.logger.debug "#{Time.zone.now} -- #{self.class.to_s}"
  end

  def forecast_args
    CONFIG.merge(:zip => @zip_code)
  end

  def full_forecast
    uri = URI(URL_STRING)
    uri.query = URI.encode_www_form(forecast_args)
    Net::HTTP.get(uri)
  end

  def json_forecast
    JSON.parse(full_forecast)
  end

  def seven_day_forecast
    json_forecast['list']
  end

  def seven_day_forecast_temperatures
    seven_day_forecast.map{|day| day['temp']}
  end

  def seven_day_forecast_low_temperatures
    seven_day_forecast_temperatures.map{|day| day['min']}
  end
end