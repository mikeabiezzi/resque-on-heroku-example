#!/usr/bin/env rake
# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

Pause::Application.load_tasks

require 'resque/tasks'

task "resque:setup" => :environment do
  ENV['QUEUE'] = '*'
end

task "resque:pause" => :environment do
  Resque.redis.set "resque_paused", true
  puts "Resque paused."
end

task "resque:resume" => :environment do
  Resque.redis.set "resque_paused", false
  puts "Resque resumed."
end

task "resque:paused" => :environment do
  paused = Resque.redis.get("resque_paused") == 'true'
  puts "Resque paused: #{paused}"
end
