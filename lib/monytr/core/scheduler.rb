require 'resque'

module Monytr
  module Core
    module Scheduler
      def self.enqueue_checks
        checks = Monytr::Core::DataStores::Yaml.checks
        checks.each do |check|
          Resque.enqueue(Monytr::Core::Processor, check.type, check.details)
        end
      end
    end
  end
end
