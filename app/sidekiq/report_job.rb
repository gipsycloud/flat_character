class ReportJob
  include Sidekiq::Worker

  def perform(*args)
    # Do something
    puts "I am ruby on rails developer, but I have not work"
  end
end
