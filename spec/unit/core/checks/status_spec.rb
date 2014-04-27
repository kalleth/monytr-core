require 'spec_helper'

shared_examples_for 'a successful check' do
  it 'succeeds' do
    Timecop.freeze do
      subject.execute
      expect(subject.performed_at).to eq Time.now
      expect(subject.breached).to eq(false)
      expect(subject.details).to eq(expected_response)
    end
  end
end

shared_examples_for 'a breaching check' do
  it 'breaches' do
    Timecop.freeze do
      subject.execute
      expect(subject.performed_at).to eq Time.now
      expect(subject.breached).to eq(true)
      expect(subject.details).to eq(expected_response)
    end
  end
end

describe Monytr::Core::Checks::Status do
  let(:url) { "http://example.com/index.html" }
  subject { Monytr::Core::Checks::Status.new('path' => url) }

  context "for a successful request" do
    before do
      stub_request(:get, url).to_return(:body => "OK", :status => 200)
    end
    let(:expected_response) { "200 OK" } 
    it_behaves_like 'a successful check'
  end

  context "when an error code is reported" do
    [400, 401, 402, 403, 404, 405, 406, 407, 408, 409, 410, 411, 412, 413, 414, 415,
     416, 417, 418, 422, 423, 424, 425, 426, 449, 450, 500, 501, 502, 503, 504,
     505, 506, 507, 509, 510].each do |error_code|
      before do
        stub_request(:get, url).to_return(:body => "Failure", :status => error_code) 
      end

      let(:expected_response) { 
        "A #{error_code} error code was encountered while fetching #{url}."
      }

      it_behaves_like 'a breaching check'
    end
  end
end
