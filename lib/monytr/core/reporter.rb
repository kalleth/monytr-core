module Monytr
  module Core
    class Reporter
      @queue = :reporting

      def self.perform(check_type, details, output)
        puts "Reporting for a '#{check_type}' check."
        puts " Details: #{details.inspect}"
        puts " Response: #{output.inspect}"
        # Persist response to storage somewhere
        # For the enabled responders, create them.
        # IE:
        #   Monytr::Core::Responders::HipChat
        #   Monytr::Core::Responders::Email
        #   Monytr::Core::Responders::Script
      end
    end
  end
end
