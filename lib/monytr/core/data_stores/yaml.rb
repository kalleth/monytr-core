require 'yaml'

module Monytr
  module Core
    module DataStores
      module Yaml
        Check = Struct.new(:type, :details) # Move out to a model when required

        class << self
          def checks
            load_checks or raise "Could not load checks from #{checks_path}"
          end

          private

          def load_checks
            YAML.load_file(checks_path).map do |data|
              Check.new(data['type'], data['details'])
            end
          end

          def checks_path
            Monytr::Core.config.data_storage['path']
          end
        end
      end
    end
  end
end
