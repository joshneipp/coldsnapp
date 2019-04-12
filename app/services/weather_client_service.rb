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

  def json_forecast_list_items
    json_forecast['list']
  end

  def compact_forecast
    json_forecast_list_items.map do |time|
      {
        date_utc: Time.at(time["dt"]).utc.to_date,
        local_date: Time.at(time["dt"]).to_date,
        utc_time: Time.at(time["dt"]).utc,
        local_time: Time.at(time["dt"]),
        day_of_week: Time.at(time["dt"]).utc.to_date.strftime("%a"),
        low_day_of_week: (Time.at(time["dt"]).utc.to_date - 1.day).strftime("%a"),
        min_temp: time['main']['temp_min'],
        max_temp: time['main']['temp_max'],
        humidity: time['main']['humidity'],
        pressure: time['main']['pressure'],
        description_main: time['weather'][0]['main'],
        description_full: time['weather'][0]['description'],
      }
    end
  end

  def highs_and_lows
    compact_forecast.group_by do |time|
      time[:local_time].between?(time[:local_time].beginning_of_day, time[:local_time].beginning_of_day + 10.hours) ? 'lows' : 'highs'
    end
  end

  def highs
    highs_and_lows.slice('highs')['highs']
  end
  
  def lows
    highs_and_lows.slice('lows')['lows']
  end

  def lows_grouped_by_day
    lows.group_by do |time_block|
      time_block[:low_day_of_week]
    end
  end

  def high_time_blocks_per_day
    high_per_day = highs.group_by do |time_block|
      time_block[:day_of_week]
    end
    high_per_day
  end

  def low_summary
    summary = {}
    lows_grouped_by_day.map do |day|
      min_for_day = day[1].min_by { |day| day[:min_temp] }.slice(:min_temp)[:min_temp].round
      summary[day[0]] = min_for_day
    end
    summary
  end

  def low_summary_to_s
    summary = "Lows:\n"
    low_summary.each do |key, val|
      summary += "#{key}: #{val}\n\n"
    end
    summary
  end

  def high_summary
    summary = {}
    high_time_blocks_per_day.map do |day|
      max_for_day = day[1].max_by { |day| day[:max_temp] }.slice(:max_temp)[:max_temp].round
      summary[day[0]] = max_for_day
    end
    summary
  end

  def high_summary_to_s
    summary = "Highs:\n"
    high_summary.each do |key, val|
      summary += "#{key}: #{val}\n\n"
    end
    summary
  end

  def high_summary_and_low_summary
    high = high_summary
    low = low_summary
  end

  def forecast_by_date
    forecast = compact_forecast.group_by { |day| day[:day_of_week] }
  end

  def compact_forecast_by_date
    forecast = {}
    forecast_by_date.group_by do |day|
      # forecast.merge!(day[1].min_by { |day| day[:min_temp] }.slice(:min_temp))
      forecast[day[0]] = {
        :min => day[1].min_by { |day| day[:min_temp] }.slice(:min_temp)[:min_temp].round,
        :max => day[1].max_by { |day| day[:max_temp] }.slice(:max_temp)[:max_temp].round
      }
      
    end
    forecast
    # forecast_by_date.map do |date|
    #   date[1].max_by do |time_block|
    #     time_block[:max_temp]
    #   end
    # end
  end

  def five_day_forecast
    json_forecast['list']
  end

  def low_temps
    five_day_forecast.map{|day| day['main']['temp_min']}
  end
end