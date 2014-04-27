module Monytr
  module Core
    module Responders
      class HipChat
        def initialize(type, details, state_change)
          @type = type
          @details = details
          @state_change = state_change
        end

        def respond
        end
      end
    end
  end
end
