# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# require File.expand_path(File.dirname(__FILE__) + '/environment')

# set :environment, Rails.env
# set :output, "#{Rails.root}/log/cron.log"

# require File.expand_path(File.dirname(__FILE__) + '/environment')

# # job_type :rake, "source /Users/saku/.zshrc; export PATH=\"$HOME/.rbenv/bin:$PATH\"; eval \"$(rbenv init - zsh)\"; cd :path && RAILS_ENV=:environment bundle exec rake :task :output"
# job_type :rake, %Q{export PATH="$HOME/.rbenv/shims:$PATH"; cd :path && RAILS_ENV=:environment bundle exec rake :task :output}

# # rails_env = ENV['RAILS_ENV'] || :development

# # set :environment, rails_env
# set :environment, Rails.env
# set :output, "#{Rails.root}/log/cron.log"

# # every 1.minutes do
# every 1.day, at: Rails.env.production? ? '6:00 pm' : '3:00 am' do
#   # command "bash #{Rails.root}/run_rake_task.sh"
#   # command "env >> #{Rails.root}/log/cron_env.log"
#   # command "which ruby >> #{Rails.root}/log/cron_env.log"
#   # command "which bundle >> #{Rails.root}/log/cron_env.log"
#   rake "vtuber_youtube:update"
# end

# require File.expand_path(File.dirname(__FILE__) + '/environment')

job_type :rake, %(export PATH="$HOME/.rbenv/shims:$PATH"; cd :path && RAILS_ENV=:environment bundle exec rake :task :output)

rails_env = ENV['RAILS_ENV'] || 'development'
set :environment, rails_env
set :output, "log/cron.log"

every 1.day, at: rails_env == 'production' ? '6:00 pm' : '3:00 am' do
  rake "vtuber_youtube:update"
end

every 2.hours do
  rake "display_order:change"
end
