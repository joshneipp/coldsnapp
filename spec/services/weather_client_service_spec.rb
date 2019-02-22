require 'rails_helper'

describe WeatherClientService do

  describe '#low_temperatures' do

    subject { WeatherClientService.new(zip_code).low_temperatures }

    let(:zip_code) { '12345' }

    it 'fetches ten days worth of forecast low temperatures' do
      expect(subject.length).to eq(10)
    end

    it 'fetches lower temperatures for Maine than for Florida' do
      maine_forecast = WeatherClientService.new('04457').low_temperatures
      florida_forecast = WeatherClientService.new('33101').low_temperatures
      expect(maine_forecast[0]).to be < florida_forecast[0]
    end
  end

end