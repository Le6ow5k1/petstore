require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Petstore::Client do
  before(:each) do
    Petstore.configure do |config|
      config.timeout = 2
    end
  end

  describe '#initialize' do
    context 'when options are given' do
      subject { Petstore::Client.new(timeout: 1) }

      it 'instansiate Client object with given options' do
        expect(subject.options).to eq({timeout: 1})
      end

      it 'sets @conn variable to be a Faraday instance with given options' do
        expect(subject.conn.options.timeout).to eq(1)
      end
    end

    context 'when options are not given' do
      subject { Petstore::Client.new }

      it 'instansiate Client object with default options' do
        expect(subject.options).to eq({timeout: 2})
      end

      it 'sets @conn variable to be a Faraday instance with default options' do
        expect(subject.conn.options.timeout).to eq(2)
      end
    end
  end

  describe '#pets' do
    subject { Petstore::Client.new }

    it 'returns an instance of Pets resource' do
      expect(subject.pets).to be_an(Petstore::Resources::Pets)
    end
  end

end