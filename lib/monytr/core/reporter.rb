require 'monytr/core/persisters'
require 'monytr/core/state_change_inspectors'
require 'pry'

module Monytr
  module Core
    class Reporter
      @queue = :reporting

      def self.perform(check_type, details, output)
        puts "Reporting for a '#{check_type}' check."
        puts " Details: #{details.inspect}"
        puts " Response: #{output.inspect}"

        # Obtain array of 'recent state changes' for this check
        history = persister.historical_checks_for(details['identifier'])
        puts " History: #{history.inspect} "

        # Determine if a 'state change' has occurred
        state_change =  Monytr::Core::StateChangeInspectors.for(check_type).detect_changes(history, output)

        if state_change
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
