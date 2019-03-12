# coldsnapp

### Sign up for notifications by text / email when freezing temperatures are forecast in your area.

### Don't let cold weather ruin your day.

### Recommended for homeowners, farmers, gardeners, contractors, or literally anyone living in an area that experiences freezing temperatures.

### No more broken pipes!

### No more flooded crawl spaces and basements!

### No more frost-damaged vegetables and flowers from unexpected frost.

### Releasing to the public later this year. (Track alpha deployments here: https://coldsnapp.herokuapp.com/user_registrations/new)

### Made possible by these APIs:

- OpenWeatherMap
- Twilio
- SendGrid (integration coming soon)

#### TODO
- integrate SendGrid REST API for sending emails
- implement a logger to capture all user-related events
- end-to-end integration tests
- deploy to Heroku
- build out React.js frontend
- upgrade to Ruby 2.6 and Rails edge
- add terms of service
- profit!

#### Run it locally yourself (for Ruby developers)
- (Recommended: install Ruby 2.5.1)
- Clone this repo
- Run `bundle install && rails db:create && rails db:migrate && rails s`
- Visit `0.0.0.0:3000/user_registrations_new` for new user signups
- Optionally visit the latest dev deployment staged at https://coldsnapp.herokuapp.com/user_registrations/new
- (Recommended: run tests with `bundle exec rspec spec --format documentation`)
