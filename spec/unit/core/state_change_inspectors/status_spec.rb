require 'spec_helper'

shared_examples_for 'a state change inspector' do
  it 'identifies flapping' do
    expect(subject.flapping?).to eq(flapping?)
  end

  it 'doesnt report a state change' do
    expect(subject.detect_changes).to eq(state_change)
  end
end

describe Monytr::Core::StateChangeInspectors::Status do
  let(:breach) { {'breached' => true, 'details' => '404 Not Found' } }
  let(:ok) { {'breached' => false} }
  let(:config) { double('config') }

  before do
    config.stub(:flapping_threshold).and_return(3)
    Monytr::Core.stub(:config).and_return(config)
  end

  subject { Monytr::Core::StateChangeInspectors::Status.new(historical_data, output) }

  context 'with a flapping check' do
    let(:historical_data) { [breach, ok, breach, ok, breach, ok] }
    let(:output) { ok }
    let(:flapping?) { true }
    let(:state_change) { nil }

    it_behaves_like 'a state change inspector'
  end

  context 'with an OK check' do
    let(:historical_data) { [ok, ok, ok] }
    let(:output) { ok }
    let(:flapping?) { false }
    let(:state_change) { nil }

    it_behaves_like 'a state change inspector'
  end

  context 'with a breaching check' do
    let(:historical_data) { [ok, ok, ok] }
    let(:output) { breach }
    let(:flapping?) { false }
    let(:state_change) { nil }

    it_behaves_like 'a state change inspector'
  end
end
