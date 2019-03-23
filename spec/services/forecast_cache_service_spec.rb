describe ForecastCacheService do
  describe '#run' do
    let(:zip_code) { '12345' }
    subject { ForecastCacheService.new(zip_code).run }

    context 'when a cached forecast exists and is less than one day old' do

      let!(:existing_forecast) { FactoryBot.create(:cached_forecast, :not_expired, zip_code: '12345') }
      
      it 'returns the existing cached forecast' do
        expect(subject).to eq(existing_forecast)
      end
    end
    
    context 'when a cached forecast exists and is more than one day old' do

      it 'runs the weather client service' do
        expect_any_instance_of(WeatherClientService).to receive(:low_temps)
        subject
      end

      it 'saves a new CachedForecast' do
        VCR.use_cassette 'saves a new CachedForecast' do
          expect do
            subject
          end
          .to change { CachedForecast.count }.by(1)
        end
      end
    end
    
    context 'when a cached forecast does not exist' do

      it 'runs the weather client service' do
        VCR.use_cassette 'runs the weather client service' do
          expect_any_instance_of(WeatherClientService).to receive(:low_temps)
          subject
        end
      end
  
      it 'saves a new CachedForecast' do
        VCR.use_cassette 'saves a new CachedForecast' do
          expect do
            subject
          end
          .to change { CachedForecast.count }.by(1)
        end
      end
    end
  end

end