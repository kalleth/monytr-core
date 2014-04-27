$:.unshift File.join(File.dirname(__FILE__), 'lib')

require 'clockwork'
require 'monytr'
# Scheduler is only required in 'clockwork' context, so is included here
# explicitly
require 'monytr/core/scheduler'

module Clockwork
  handler do |job, time|
    puts "Running #{job} at #{time}"
  end

  every(5.minutes, 'checks.enqueue') { Monytr::Core::Scheduler.enqueue_checks }
end
