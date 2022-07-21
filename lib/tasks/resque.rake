require 'resque/tasks'
task 'resque:setup' => :environment do
  require 'resque'
  ENV['QUEUE'] = '*'

  Resque.redis = Redis.new(url: ENV.fetch('REDIS_URL'))
end
