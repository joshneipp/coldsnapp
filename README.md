# coldsnapp

## Don't let weird weather ruin your day!

### Get alerts about unusual and noteworthy weather in your area

### Configure which weather events you want to be notified about, and how to receive notifications
* Notify by text or email
* Get notified up to 10 days out
* Choose from types of weather events (such as subfreezing temps, multiple rain days, snow/ice, heat wave, hurricane)

### Made possible by these APIs:

- OpenWeatherMap
- Twilio
- SendGrid

#### TODO
- better logging of all user-related events, external api calls, and system errors
- end-to-end integration tests
- profit!

#### Run it locally yourself (for developers)
- (Recommended: install Ruby 2.5.1)
- Clone this repo
- Run `bundle install && rails db:create && rails db:migrate && rails s`
- Visit `0.0.0.0:3000/` for new user signups
- (Recommended: run tests with `bundle exec rspec spec --format documentation`)

#### Work in progress.... check back often
