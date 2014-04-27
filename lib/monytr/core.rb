require 'monytr/core/persisters'
require 'monytr/core/processor'

module Monytr
  module Core
    def self.config
      @config ||= OpenStruct.new(YAML.load_file('config/config.yml'))
    end
  end
end
