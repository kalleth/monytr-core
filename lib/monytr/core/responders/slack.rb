require 'slack-notifier'

module Monytr
  module Core
    module Responders
      class Slack
        def self.notifier
          @notifier ||= ::Slack::Notifier.new(responder_config[:team], responder_config[:token])
        end

        def self.responder_config
          Monytr::Core.config.responders[:slack]
        end

        def initialize(type, details, state_change)
          @type = type
          @details = details
          @state_change = state_change
        end

        def respond
          self.class.notifier.ping(
            "<!channel> state change detected!",
            channel: room,
            attachments: [attachment_data],
          )
        end

        def attachment_data
          extra_data = if @state_change.good?
            {
              color: "good",
            }
          else
            {
              color: "danger",
            }
          end

          extra_data.merge({fallback: message, text: message})
        end

        def message
          path = @details['path']
          if @state_change.good?
            "#{@details['identifier']} (#{@type} check on #{path}) returned to normal."
          else
            message = "Check failed on #{@details['identifier']}. Site may be down.\n\n"
            message += "Details: \n"
            message += "#{@state_change.output['details']}"
          end
        end

        private

        def room
          @details['responders']['slack']['room'] rescue nil
        end
      end
    end
  end
end
