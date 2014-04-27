require 'monytr/core/persisters'
require 'monytr/core/state_change_inspectors'

module Monytr
  module Core
    class Reporter
      @queue = :reporting

      def self.perform(check_type, details, output)
        # Obtain array of 'recent state changes' for this check
        history = persister.historical_checks_for(details['identifier'])

        # Determine if a 'state change' has occurred
        state_change =  Monytr::Core::StateChangeInspectors.for(check_type).new(history, output).detect_changes

        if state_change
          puts "State change detected for #{check_type}"
          puts " Details: #{details.inspect}"
          puts " Output: #{output.inspect}"
          # Create responders
          # For the enabled responders, create them.
          # IE:
          #   Monytr::Core::Responders::HipChat
          #   Monytr::Core::Responders::Email
          #   Monytr::Core::Responders::Script
        end

        persister.store_new_entry(details['identifier'], output)
      end
      
      private
      def self.persister
        @persister ||= Monytr::Core::Persisters::Redis.new
      end
    end
  end
end
