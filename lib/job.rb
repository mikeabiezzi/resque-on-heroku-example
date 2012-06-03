class Job
  class << self
    attr_accessor :stop
  end

  @queue  = :jobs

  def self.perform from, through
   (from..through).each do |item|
    if Job.stop
      Resque.enqueue Job, item, through
      puts "Enqueued Job (#{item},#{through})"
      return
    end
    sleep 1
    puts "Processed #{item}"
   end
  end
end

trap('TERM') do
  Job.stop = true
end
