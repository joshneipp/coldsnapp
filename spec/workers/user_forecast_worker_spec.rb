require 'sidekiq/testing'
Sidekiq::Testing.inline!

describe UserForecastWorker do
  subject { UserForecastWorker.new.perform }

  context 'when user next_forecast_check_time is past due' do
    context 'when the user settings indicate the user wants to be notified of freezing weather and there is freezing weather in the forecast' do
      let!(:user) { FactoryBot.create(:user, :notify_of_frost) }

      before do
        user.update_attributes!(next_forecast_check_time: (Time.now - 1.minute))
      end

      it 'uses the weather client to fetch a new forecast' do
        VCR.use_cassette 'new cold forecast' do
          stub_weather_client_service
          expect_any_instance_of(WeatherClientService).to receive(:low_temps)
          subject
        end
      end

      it 'checks for a cached forecast for the users zip code' do
        expect_any_instance_of(ForecastCacheService).to receive(:run)
        subject
      end

      it 'updates the user' do
        VCR.use_cassette 'running the UserForecastWorker' do
          stub_weather_client_service
          stub_twilio_request
          expect(User.find(user.id).next_forecast_check_time).to be < (Time.now)
          subject
          expect(User.find(user.id).next_forecast_check_time).to be > (Time.now + 23.hours)
        end
      end

      it 'sends the user a message' do
        VCR.use_cassette 'running the UserForecastWorker' do
          stub_twilio_request
          stub_weather_client_service
          expect_any_instance_of(TwilioService).to receive(:send_message)
          subject
        end
      end
    end
  end
end

# TODO extract this into a helper
def stub_forecast_cache_service
  allow_any_instance_of(ForecastCacheService).to receive(:run)
end

def stub_weather_client_service
  allow_any_instance_of(WeatherClientService).to receive(:low_temps).and_return([31, 31, 31, 31, 31, 31, 31, 31, 31, 31])
end

def stub_twilio_request
  allow_any_instance_of(TwilioService).to receive(:send_message)
end