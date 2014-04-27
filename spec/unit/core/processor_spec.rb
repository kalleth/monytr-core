require 'spec_helper'

describe Monytr::Core::Processor do
  let(:type) { 'generic' }
  let(:details) { 'can be anything' }
  let(:check_class) { double('check_class') }
  let(:check) { double('check') }

  subject { Monytr::Core::Processor }

  before do
    check.stub(:attributes)
    check.stub(:execute).and_return(check)
    Monytr::Core::Checks.stub(:for).with(type).and_return(check_class)
  end

  it 'calls the correct check type' do
    expect(check_class).to receive(:new).with(details).and_return check
    subject.perform(type, details)
  end

  it 'raises when check not found' do
    expect { subject.perform('flibble', details) }.to raise_error
  end
end
