require 'rails_helper'

describe CachedForecast do

    describe '#expired?' do

        context 'when a forecast is less than one day old' do
            let(:forecast) { FactoryBot.build(:cached_forecast, :not_expired) }
            it 'is false' do
                expect(forecast.expired?).to be_falsey
            end
        end
        
        context 'when a forecast is more than one day old' do
            let(:forecast) { FactoryBot.build(:cached_forecast, :expired) }
            it 'is true' do
                expect(forecast.expired?).to be_truthy
            end
        end
    end

    describe 'low_temperatures' do
        let(:forecast) { FactoryBot.build(:cached_forecast, :not_expired) }

        it 'saves 10 days of forecasted temperatures' do
            expect(forecast.low_temperatures.length).to eq(10)
        end
    end
end