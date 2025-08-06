# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

require File.expand_path(File.dirname(__FILE__) + '/environment')

set :environment, Rails.env
set :output, "#{Rails.root}/log/cron.log"

if Rails.env.production?
  env :PATH, '/usr/local/bin:/usr/bin:/bin'
  every 1.day, at: '6:00 pm' do
    command "bash #{Rails.root}/run_rake_task.sh"
  end
elsif Rails.env.development?
  env :PATH, '/Users/saku/.rbenv/shims:/Users/saku/.rbenv/bin:/usr/local/bin:/usr/bin:/bin'
  # every 5.minutes do
  every 1.day, at: '3:00 am' do
    command "bash #{Rails.root}/run_rake_task.sh"
  end
end
