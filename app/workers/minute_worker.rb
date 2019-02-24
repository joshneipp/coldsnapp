class MinuteWorker
  include Sidekiq::Worker

  def perform(args)
    Rails.logger.debug "This will log to the development logs"
    puts "This will log to the sidekiq logs"
  end
end
