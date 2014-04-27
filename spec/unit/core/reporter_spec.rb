require 'spec_helper'

describe Monytr::Core::Reporter do
  subject { Monytr::Core::Reporter }
  let(:persister) { double('persister') }
  let(:id) { 'generic-check'}
  let(:type) { 'generic' }
  let(:output) { 'random output' }
  let(:details) { {'identifier' => id} }
  let(:inspector_class) { double('inspector-class') }
  let(:inspector) { double('inspector') }
  let(:state_change) { double('state-change') }
  let(:responder_class) { double('responder-class') }
  let(:responder) { double('responder') }

  before do
    persister.stub(:historical_checks_for).and_return []
    persister.stub(:store_new_entry)
    subject.stub(:persister).and_return(persister)
    inspector.stub(:detect_changes).and_return(state_change)
    inspector_class.stub(:new).and_return(inspector)
    responder.stub(:respond)
    responder_class.stub(:new).and_return(responder)
    Monytr::Core::StateChangeInspectors.stub(:for).with(type).and_return(inspector_class)
    Monytr::Core::Responders.stub(:for).with(details).and_return([responder_class])
  end

  it 'stores a new entry each time' do
    expect(persister).to receive(:store_new_entry).with(id, output)
    subject.perform(type, details, output)
  end

  it 'triggers responders' do
    expect(responder_class).to receive(:new).with(type, details, state_change)
    expect(responder).to receive(:respond)
    subject.perform(type, details, output)
  end
end
