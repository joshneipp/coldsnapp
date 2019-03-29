require 'rails_helper'

describe WeatherClientService do

  describe '#json_forecast' do
    subject { WeatherClientService.new(zip_code).json_forecast }
    let(:zip_code) { '27278' }

    it "has top keys 'cod' 'message' 'cnt' and 'list'" do
      VCR.use_cassette('json_forecast') do
        %w(cod message cnt list).each do |top_key|
          expect(subject).to have_key(top_key)
        end
      end
    end

    it 'returns 40 results: one forecast every 3 hours for the next 5 days' do
      VCR.use_cassette('json_forecast') do
        expect(subject['cnt']).to eq(40)
      end
    end
  end

  describe '#compact_forecast' do
    subject { WeatherClientService.new(zip_code).compact_forecast }
    let(:zip_code) { '27278' }

    it 'returns an array' do
      VCR.use_cassette('compact forecast') do
        expect(subject.class).to eq(Array)
      end
    end

    it 'returns min and max temp and description with each time block' do
      VCR.use_cassette('compact forecast') do
        subject.each do |time_block|
          %w(date time max_temp min_temp description_full).each do |key|
            expect(time_block).to have_key(key.to_sym)
          end
        end
      end
    end

    it 'returns 40 results: one forecast every 3 hours for the next 5 days' do
      VCR.use_cassette('compact forecast') do
        expect(subject.size).to eq(40)
      end
    end
  end

  describe '#forecast_by_date' do
    subject { WeatherClientService.new(zip_code).forecast_by_date }
    let(:zip_code) { '27278' }

    it 'has daytime high temps and nighttime low temps' do
      VCR.use_cassette('daily forecast') do
        expect(subject.size).to eq(5)
      end
    end
  end

  describe '#compact_forecast_by_date' do
    subject { WeatherClientService.new(zip_code).compact_forecast_by_date }
    let(:zip_code) { '27278' }

    it 'has daytime high temps and nighttime low temps' do
      VCR.use_cassette('daily forecast') do
        expect(subject.size).to eq(5)
      end
    end
  end

  describe '#highs_and_lows' do
    subject { WeatherClientService.new(zip_code).highs_and_lows }
    let(:zip_code) { '27278' }

    it 'splits the forecast into highs and lows' do
      VCR.use_cassette('nighttime_low_time_blocks') do
        expect(subject.size).to eq(2)
        %w(highs lows).each do |key| 
          expect(subject).to have_key(key)
        end
      end
    end
  end

  describe '#lows' do
    subject { WeatherClientService.new(zip_code).lows }
    let(:zip_code) { '27278' }

    it 'returns nighttime lows' do
      VCR.use_cassette('lows') do
        expect(subject.size ).to eq(1)
      end
    end
  end

  describe '#low_per_day' do
    subject { WeatherClientService.new(zip_code).low_per_day }
    let(:zip_code) { '27278' }

    it 'returns one low per day' do
      VCR.use_cassette('low_per_day') do
        expect(subject.size ).to eq(1)
      end
    end
  end

  describe '#low_summary' do
    subject { WeatherClientService.new(zip_code).low_summary }
    let(:zip_code) { '27278' }

    it 'returns one low per day' do
      VCR.use_cassette('low_summary') do
        expect(subject.size ).to eq(5)
      end
    end
  end

  describe '#high_summary' do
    subject { WeatherClientService.new(zip_code).high_summary }
    let(:zip_code) { '27278' }

    it 'returns one low per day' do
      VCR.use_cassette('high_summary') do
        expect(subject.size ).to eq(5)
      end
    end
  end

  describe '#high_summary_and_low_summary' do
    subject { WeatherClientService.new(zip_code).high_summary_and_low_summary }
    let(:zip_code) { '27278' }

    it 'returns one low per day' do
      VCR.use_cassette('high_summary_and_low_summary') do
        expect(subject.size ).to eq(5)
      end
    end
  end

  describe '#forecast_by_day_and_night' do
    subject { WeatherClientService.new(zip_code).forecast_by_day_and_night }
    let(:zip_code) { '27278' }

    it 'has daytime high temps and nighttime low temps' do
      VCR.use_cassette('daily forecast') do
        expect(subject.size).to eq(6)
      end
    end
  end

  describe '#low_temps' do

    subject { WeatherClientService.new(zip_code).low_temps }
    let(:zip_code) { '27278' }

    it 'fetches weather data for every 3 hours for the next 5 days' do
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