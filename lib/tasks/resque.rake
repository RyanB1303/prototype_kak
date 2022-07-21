require 'resque/tasks'
task 'resque:setup' => :environment do
  require "resque"
  
  ENV['QUEUE'] = '*'
  Resque.redis = Redis.current
end
