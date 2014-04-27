require 'redis'
require 'json'

module Monytr
  module Core
    module Persisters
      class Redis
        def initialize
          @redis = ::Redis.new
        end

        def historical_checks_for(identifier)
          (JSON.parse(@redis.get(key(identifier))) rescue []) || []
        end

        def store_new_entry(identifier, data)
          historical = historical_checks_for(identifier)
          historical = [] unless historical.kind_of? Array
          historical.pop if historical.size > Monytr::Core.config.stored_records
          historical.unshift(data) # Insert new
          @redis.set(key(identifier), historical.to_json)
        end

        private

        def key(id)
          "monytr-historical-#{id}"
        end
      end
    end
  end
end
