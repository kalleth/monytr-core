require 'monytr/core/responders/hipchat'

module Monytr
  module Core
    module Responders
      def for(check_details)
        check_details['responders'].map { |r_code| responder_for(r_code) }.compact
      end

      private

      def responder_for(code)
        case code
        when :hipchat then Monytr::Core::Responders::HipChat
        else nil
        end
      end
    end
  end
end
