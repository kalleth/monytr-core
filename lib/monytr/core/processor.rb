require 'monytr/core/checks'
require 'pry'

module Monytr
  module Core
    class Processor
      @queue = :processing

      def self.perform(check_type, details)
        klass = Monytr::Core::Checks.for(check_type)
        raise "Couldn't find checker for '#{check_type}'" unless klass 
        checker = klass.new(details).execute 
      end
    end
  end
end
