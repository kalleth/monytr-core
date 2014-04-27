require 'monytr/core'
require 'webmock/rspec'
require 'fakeredis/rspec'
require 'timecop'

RSpec.configure do |config|
  config.order = "random"
end
