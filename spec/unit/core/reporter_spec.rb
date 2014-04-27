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

  before do
    persister.stub(:historical_checks_for).and_return []
    subject.stub(:persister).and_return(persister)
    inspector.stub(:detect_changes)
    inspector_class.stub(:new).and_return(inspector)
    Monytr::Core::StateChangeInspectors.stub(:for).with(type).and_return(inspector_class)
  end

  it 'stores a new entry each time' do
    expect(persister).to receive(:store_new_entry).with(id, output)
    subject.perform(type, details, output)
  end
end
