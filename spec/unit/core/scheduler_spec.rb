require 'spec_helper'
require 'monytr/core/scheduler'

describe Monytr::Core::Scheduler do
  let(:check) { double("check") }

  before do
    check.stub(:type).and_return('status')
    check.stub(:details).and_return('details')
    Monytr::Core::Persisters::Yaml.stub(:checks).and_return([check, check])
  end

  it "queues checks" do
    expect(Resque).to receive(:enqueue).with(Monytr::Core::Processor, 'status', 'details').twice
    subject.enqueue_checks
  end
end
