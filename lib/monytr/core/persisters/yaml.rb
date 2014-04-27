module Monytr
  module Core
    module Persisters
      class Yaml
        def self.checks
          YAML.load_file('config/checks.yml')
        end
      end
    end
  end
end
