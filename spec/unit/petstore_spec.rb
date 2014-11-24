require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Petstore do

  describe '#configure' do
    subject { Petstore }

    it 'sets configuration options' do
      Petstore.configure { |c| c.timeout = 3 }

      expect(subject.timeout).to eq(3)
    end
  end

  describe '#initialize' do
    subject { Petstore.new }

    it 'creates Client instance' do
      expect(subject).to be_an(Petstore::Client)
    end
  end
end