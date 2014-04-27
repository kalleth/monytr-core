require 'monytr/core/checks/status'

module Monytr
  module Core
    module Checks
      def self.for(type)
        case type
        when 'status' then Monytr::Core::Checks::Status
        else nil
        end
      end
    end
  end
end
