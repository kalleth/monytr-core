$:.unshift File.dirname(__FILE__)

require 'clockwork'
require 'lib/monytr/core/scheduler'

module Clockwork
  handler do |job, time|
    puts "Running #{job} at #{time}"
  end

  every(5.minutes, 'checks.enqueue') { Monytr::Core::Scheduler.enqueue_checks }
end
