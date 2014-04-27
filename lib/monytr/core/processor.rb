module Monytr
  module Core
    class Processor
      @queue = :processing

      def self.perform(check_type, details)
        puts "Performing check: #{check_type}"
        puts " Details: #{details.inspect}"
      end
    end
  end
end
