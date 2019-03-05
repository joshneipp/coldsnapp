class RandomTimeService

  def self.random_minute_in_the_morning
    Time.now.beginning_of_day + rand(0..900).minutes
  end
end