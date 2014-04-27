require 'spec_helper'

describe Monytr::Core::DataStores::Yaml do
  let(:sample_data) {
    [
      {'type' => 'basic', 'details' => 'rich_object'},
      {'type' => 'complex', 'details' => 'richer_object'}
    ]
  }

  it "returns objects responding to type and details" do
    YAML.stub(:load_file).and_call_original
    YAML.stub(:load_file).with('config/checks.yml').and_return(sample_data)

    checks = subject.checks
    expect(checks.size).to eq(2)
    check = checks[0]
    expect(check.type).to eq('basic')
    expect(check.details).to eq('rich_object')
  end
end
