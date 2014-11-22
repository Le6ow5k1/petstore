# require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')
require_relative '../../lib/petstore'
require_relative '../../lib/petstore/client'

describe Petstore::Client do
  before(:each) do
    Petstore.configure do |config|
      config.timeout = 1000
    end
  end

  describe "#initialize" do
    context "when options are given" do
      subject { Petstore::Client.new(timeout: 100) }

      it "instansiate Client object with given options" do
        expect(subject.options).to eq({timeout: 100})
      end
    end

    context "when options are not given" do
      subject { Petstore::Client.new }

      it "instansiate Client object with default options" do
        expect(subject.options).to eq({timeout: 1000})
      end
    end
  end
  
end