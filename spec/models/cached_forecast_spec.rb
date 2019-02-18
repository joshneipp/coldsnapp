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
end