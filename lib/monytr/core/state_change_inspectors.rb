require 'monytr/core/state_change_inspectors/status'

module Monytr
  module Core
    module StateChangeInspectors
      class Result < Struct.new(:from, :to, :output);
        def good?
          to == false # if 'to state' is true, it means we're breaching. Which is bad.
        end
      end
      def self.for(type)
        case type
        when 'status' then Monytr::Core::StateChangeInspectors::Status
        else nil
        end
      end
    end
  end
end
