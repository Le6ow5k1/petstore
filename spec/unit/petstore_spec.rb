require_relative '../../lib/petstore'
require_relative '../../lib/petstore/client'

describe Petstore do

  describe "#configure" do
    subject { Petstore }

    it "sets configuration options" do
      Petstore.configure { |c| c.timeout = 300 }

      expect(subject.timeout).to eq(300)    
    end
  end

  describe "#initialize" do
    subject { Petstore.new }

    it "creates Client instance" do
      expect(subject).to be_an(Petstore::Client)
    end
  end
end