require 'monytr/core/responders/hipchat'
require 'monytr/core/responders/email'

module Monytr
  module Core
    module Responders
      def self.for(check_details)
        check_details['responders'].map { |code, configs| responder_for(code) }.compact
      end

      private

      def self.responder_for(code)
        case code
        when 'hipchat' then Monytr::Core::Responders::HipChat
        when 'email' then Monytr::Core::Responders::Email
        else nil
        end
      end
    end
  end
end
