require 'vcr'

VCR.configure do |config|
  config.cassette_library_dir = "spec/fixtures/vcr_cassettes"
  config.hook_into :webmock
  config.filter_sensitive_data('<TWILIOAPIKEY>') { ENV["TWILIO_ACCOUNT_SID"]}
  config.filter_sensitive_data('<TWILIOFROM>') { ENV["TWILIO_TEST_SMS_FROM"]}
  config.filter_sensitive_data('<TWILIOFROM>') { ENV["TWILIO_SMS_FROM"]}
  config.filter_sensitive_data('<TWILIOTO>') { ENV["TWILIO_TEST_SMS_TO"]}
  config.filter_sensitive_data('<AUTHTOKEN>') { ENV["TWILIO_AUTH_TOKEN"]}
  config.filter_sensitive_data('<WEATHERAPIKEY>') { ENV["OPEN_WEATHER_API_KEY"]}
  config.filter_sensitive_data('<SENDGRID_TEST_FROM>') { ENV["SENDGRID_TEST_FROM"]}
  config.filter_sensitive_data('<SENDGRID_TEST_TO>') { ENV["SENDGRID_TEST_TO"]}
  config.filter_sensitive_data('<SENDGRID_API_KEY>') { ENV["SENDGRID_API_KEY"]}
  config.before_record do |i|
    i.response.body.force_encoding('UTF-8')
  end
end