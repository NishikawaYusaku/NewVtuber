# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

require File.expand_path(File.dirname(__FILE__) + '/environment')

set :environment, Rails.env
set :output, "#{Rails.root}/log/cron.log"

# 1日1回（開発・本番とも同じスケジュール）
every 1.day, at: Rails.env.production? ? '6:00 pm' : '3:00 am' do
  command "bash #{Rails.root}/run_rake_task.sh"
end
