require 'monytr/core/data_stores'
require 'monytr/core/processor'

module Monytr
  module Core
    class << self
      def config
        @config ||= OpenStruct.new(YAML.load_file(config_path))
      end

      private
      def config_path
        File.join('config/config.yml')
      end
    end
  end
end
