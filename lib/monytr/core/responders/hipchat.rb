require 'hipchat'

module Monytr
  module Core
    module Responders
      class HipChat
        def self.client
          @client ||= ::HipChat::Client.new(responder_config[:api_key]) 
        end

        def self.responder_config
          Monytr::Core.config.responders[:hipchat]
        end

        def initialize(type, details, state_change)
          @type = type
          @details = details
          @state_change = state_change
        end

        def respond
          user = "Monytr"
          path = @details['path']
          if @state_change.good?
            message = "#{@details['identifier']} (#{@type} check on <a href=\"#{path}\">#{path}</a>) returned to normal."
            color = "green"
          else
            message = "<strong>Warning!</strong> Check failed on #{@details['identifier']}. Site may be down.<br />"
            message += "Details: <br />"
            message += "&nbsp;&nbsp;#{@state_change.output['details']}"
            color = "red"
          end
          self.class.client[responder_config[:room]].send(user, message, color: color, notify: true)
        end

        private

        def responder_config
          self.class.responder_config
        end
      end
    end
  end
end
