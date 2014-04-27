require 'resque'

module Monytr
  module Core
    module Scheduler
      def self.enqueue_checks
        puts "Loading checks from persistence layer"
        puts "(Strategy: YAML)"
        checks = Monytr::Core::Persisters::Yaml.checks
        checks.each do |check|
          puts " - Queueing: #{check.type}"
          Resque.enqueue(Monytr::Core::Processor, check.type, check.details)
        end
      end
    end
  end
end
