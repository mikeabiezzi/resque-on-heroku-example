unless ENV["REDISTOGO_URL"].nil?
  uri = URI.parse(ENV["REDISTOGO_URL"])
  Resque.redis = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)
  Resque::Plugins::Status::Hash.expire_in = (48 * 60 * 60) # We don't want the statii hanging around forever (aka "completed,working,etc"... so expire in 48 hrs
end

# Patch to Resque to allow pausing and resuming of workers.
module Resque
  class Worker
    alias :original_reserve :reserve
    def reserve( interval )
      unless Resque.redis.get("resque_paused") == "true"
        self.original_reserve interval
      end
    end
  end
end
