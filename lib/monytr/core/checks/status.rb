module Monytr
  module Core
    module Checks
      class Status
        RequestError = Struct.new(:code)
        attr_accessor :performed_at, :breached, :details

        def initialize(attrs)
          @path = attrs['path']
        end

        def execute
          handle_response(make_request)
          self
        end

        private
        
        def make_request
          @performed_at = Time.now
          uri = URI.parse(@path) 
          request = Net::HTTP::Get.new(uri.request_uri)
          http = Net::HTTP.new(uri.host, uri.port)
          http.request(request)
        rescue # XXX Needs to be made more specific so we dont prevent shutdown
          @breached = true
          @details = "An error was encountered while fetching #{@path}.\n\nThe error was: #{$!.message}"
          RequestError.new("Internal Error")
        end

        def handle_response(response)
          if response.code == "200" 
            @breached = false
            @details = "200 OK"
          else
            @breached = true
            @details = "A #{response.code} error code was encountered while fetching #{@path}."
          end
        end
      end
    end
  end
end
