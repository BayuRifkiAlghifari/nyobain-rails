class BookWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform(time, time2)
    puts "Execute at #{time} #{time2}"
  end
end
 
