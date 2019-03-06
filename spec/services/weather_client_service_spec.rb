require 'rails_helper'

describe WeatherClientService do

  describe '#seven_day_forecast' do

    subject { WeatherClientService.new(zip_code).seven_day_forecast }
    let(:zip_code) { '27278' }

    it 'fetches weather data for the next 7 days' do
      VCR.use_cassette('fetches weather data for the next 7 days') do
        expect(subject.length).to eq(7)
      end
    end
  end

  describe '#seven_day_forecast_low_temperatures' do

    subject { WeatherClientService.new(zip_code).seven_day_forecast_low_temperatures }
    let(:zip_code) { '12345' }

    it 'fetches seven days worth of forecast low temperatures' do
      VCR.use_cassette('fetches seven days worth of forecast low temperatures') do
        expect(subject.length).to eq(7)
      end
    end

    it 'fetches lower temperatures for Maine than for Florida' do
      VCR.use_cassette('fetches lower temperatures for Maine than for Florida') do
        maine_forecast = WeatherClientService.new('04457').seven_day_forecast_low_temperatures
        florida_forecast = WeatherClientService.new('33101').seven_day_forecast_low_temperatures
        expect(maine_forecast[0]).to be < florida_forecast[0]
      end
    end
  end
end