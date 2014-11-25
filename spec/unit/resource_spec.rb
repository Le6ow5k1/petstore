require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Petstore::Resource do
  describe '.set_path' do
    before do
      class TestResource < Petstore::Resource; end
      TestResource.set_path '/test'
    end

    let(:subject) { TestResource.new('') }
    it 'sets the path for that class instance' do
      expect(subject.path).to eq('/test')
    end
  end
end