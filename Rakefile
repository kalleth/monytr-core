$:.unshift File.join(File.dirname(__FILE__), 'lib')

require 'monytr/core'
require 'monytr/core/responders'
require 'resque/tasks'

namespace :test do
  desc "Tests a responder by sending a fake down message."
  task :responder do
    responder_id = ENV['RESPONDER']
    if responder_id.nil? || responder_id.empty?
      puts "You must provide a responder name in RESPONDER environment variable!"
      puts "Available responders: #{Monytr::Core.config['responders'].keys.join(", ")}"
      puts "eg: rake test:responder RESPONDER=email"
      raise
    end

    state_change = OpenStruct.new(
      good?: false,
      output: {
        'details' => "This is a test alert message. Please take no action.",
      }
    )

    details = OpenStruct.new(
      path: "http://www.example.com/",
      identifier: "example-check",
    )

    type = 'status'

    responder_klass = Monytr::Core::Responders.responder_for(responder_id)

    puts "Testing a #{responder_klass.inspect} responder..."

    responder_klass.new(type, details, state_change).respond

    puts "Complete."
  end
end
