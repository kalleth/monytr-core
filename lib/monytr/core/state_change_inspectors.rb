require 'monytr/core/state_change_inspectors/status'

module Monytr
  module Core
    module StateChangeInspectors
      def self.for(type)
        case type
        when 'status' then Monytr::Core::StateChangeInspectors::Status
        else nil
        end
      end
    end
  end
end
