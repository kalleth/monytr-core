module Monytr
  module Core
    module StateChangeInspectors
      class Status
        def initialize(historical_data, output)
          @historical_data = historical_data
          @output = output
        end

        def detect_changes 
          return nil if flapping?
        end

        # A 'check' is said to be flapping if it's changed more than a certain
        # number of times in the last N checks.
        #
        # We don't report when a check is flapping (the first 'state change' to
        # down will already have been reported), as that could get annoying
        # (and not very useful).
        def flapping?
          recent_changes = ([@output] + @historical_data).map { |h| h['breached'] }
          squeezed = recent_changes.inject([]){|acc,i| acc.last == i ? acc : acc << i }
          squeezed.size > Monytr::Core.config.flapping_threshold.to_i
        end
      end
    end
  end
end
