# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require_relative 'config/application'
require 'resque/tasks'

task 'resque:setup' => :environment do
  require "resque"
  
  ENV['QUEUE'] = '*'
  Resque.redis = Redis.current
end

Rails.application.load_tasks
