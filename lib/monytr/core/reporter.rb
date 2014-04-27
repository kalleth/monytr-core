require 'monytr/core/persisters'
require 'monytr/core/state_change_inspectors'
require 'monytr/core/responders'
require 'pry'

module Monytr
  module Core
    class Reporter
      @queue = :reporting

      def self.perform(check_type, details, output)
        # Obtain array of 'recent state changes' for this check
        history = persister.historical_checks_for(details['identifier'])

        # Determine if a 'state change' has occurred
        state_change =  Monytr::Core::StateChangeInspectors.for(check_type).new(history, output).detect_changes

        #puts "STATE CHANGE: #{state_change.inspect}"
        if state_change
          Monytr::Core::Responders.for(details).each do |responder|
            responder.new(check_type, details, state_change).respond
          end
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
