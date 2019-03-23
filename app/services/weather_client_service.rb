require 'open_weather'
require 'net/http'
require 'openssl'
require 'json'

class WeatherClientService
  CONFIG = {
    units: 'imperial',
    appid: ENV["OPEN_WEATHER_API_KEY"]
  }

  URL_STRING = 'https://cors-anywhere.herokuapp.com/http://api.openweathermap.org/data/2.5/forecast/'

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
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_PEER
    request = Net::HTTP::Get.new(uri.request_uri)
    request['X-Requested-With'] = 'XMLHttpRequest'

    response = http.request(request)

    Rails.logger.info "###############"
    Rails.logger.info "WeatherClientResponse..."
    Rails.logger.info "#{response.body.inspect}"
    Rails.logger.info "###############"
    return response.body
  end

  def json_forecast
    JSON.parse(full_forecast)
  end

  def five_day_forecast
    json_forecast['list']
  end

  def low_temps
    five_day_forecast.map{|day| day['main']['temp_min']}
  end
end