require 'mail'

module Monytr
  module Core
    module Responders
      class Email
        # Use letter_opener in development mode.
        if ENV['RUBY_ENV'] && ENV['RUBY_ENV'] == "development"
          require "letter_opener"
          Mail.defaults do
            delivery_method LetterOpener::DeliveryMethod, :location => File.expand_path('../tmp/letter_opener', __FILE__)
          end
        else
          Mail.defaults do
            delivery_method :sendmail
          end
        end

        def initialize(type, details, state_change)
          @type = type
          @details = details
          @state_change = state_change
        end

        def respond
          that = self
          Mail.deliver do
            from      that.responder_config[:from]
            to        that.targets 
            subject   that.subject 
            body      that.body 
          end
        end

        def subject
          if @state_change.good?
            "#{responder_config[:prefix]} #{@details['identifier']} returned to normal."
          else
            "#{responder_config[:prefix]} WARNING - Check failed for #{@details['identifier']}. Site may be down."
          end
        end

        def body
          if @state_change.good?
            msg = "#{@details['identifier']} has returned to a normal/non-breaching state."
            msg += " (a #{@type} check on #{@details['path']})"
          else
            msg = "Warning! Check failed on #{@details['identifier']}. Site may be down.\n"
            msg += "Details:\n\n"
            msg += "  #{@state_change.output['details']}"
          end
        end

        def targets
          @details['responders']['email']['targets']
        end

        def responder_config
          Monytr::Core.config.responders[:email]
        end
      end
    end
  end
end
