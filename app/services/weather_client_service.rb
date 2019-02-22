require 'open_weather'
require 'net/http'
require 'json'

class WeatherClientService
  CONFIG = {
    units: 'imperial',
    appid: ENV["OPEN_WEATHER_API_KEY"]
  }

  def initialize(zip_code)
    @zip_code = zip_code
  end

  def low_temperatures
    forecast_list.map { |time| time['main']['temp']}

    # [31, 32, 33, 34, 35, 36, 37, 38, 39, 31]
  end

  def forecast
    uri = URI('http://api.openweathermap.org/data/2.5/forecast')
    args = CONFIG.merge(:zip => @zip_code)
    uri.query = URI.encode_www_form(args)
    res = Net::HTTP.get(uri)
    byebug
    @response = JSON.parse(res)
  end

  def forecast_list
    forecast['list']
  end
end