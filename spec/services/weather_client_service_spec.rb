require 'rails_helper'

describe WeatherClientService do

  describe '#low_temps' do

    subject { WeatherClientService.new(zip_code).low_temps }
    let(:zip_code) { '27278' }

    it 'fetches weather data for the next 5 days' do
      VCR.use_cassette('fetches weather data for the next 5 days') do
        expect(subject.length).to eq(39)
      end
    end
  end

  describe '#low_temps' do

    subject { WeatherClientService.new(zip_code).low_temps }
    let(:zip_code) { '27278' }

    it 'fetches a forecast for every 3 hours for the next five days' do
      VCR.use_cassette('fetches five days worth of forecast low temperatures') do
        expect(subject.length).to eq(39)
      end
    end

    it 'fetches lower temperatures for Maine than for Florida' do
      VCR.use_cassette('fetches lower temperatures for Maine than for Florida') do
        maine_forecast = WeatherClientService.new('04457').low_temps
        florida_forecast = WeatherClientService.new('33101').low_temps
        expect(maine_forecast[0]).to be < florida_forecast[0]
      end
    end
  end
end