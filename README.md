# coldsnapp

### Sign up for notifications by text / email when freezing temperatures are forecast in your area.

### Don't let cold weather ruin your day!

### Recommended for homeowners, farmers, gardeners, contractors, or literally anyone living in an area that experiences freezing temperatures.

### Releasing to the public later this year. (Track alpha deployments here: https://coldsnapp.herokuapp.com/)

### Made possible by these APIs:

- OpenWeatherMap
- Twilio
- SendGrid

#### TODO
- better logging of all user-related events, external api calls, and system failures
- end-to-end integration tests
- add terms of service
- profit!

#### Run it locally yourself (for Ruby developers)
- (Recommended: install Ruby 2.5.1)
- Clone this repo
- Run `bundle install && rails db:create && rails db:migrate && rails s`
- Visit `0.0.0.0:3000/` for new user signups
- (Recommended: run tests with `bundle exec rspec spec --format documentation`)
