require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Petstore::Request do
  before(:each) do
    @request = Petstore::Request.new(conn: '', partial_path: '', method: '')
  end

  describe '#mime_type' do
    context 'with filename with .jpg extension passed' do
      let(:subject) { @request.send(:mime_type, 'file.name.jpg') }

      it 'returns image/jpeg string' do
        expect(subject).to eq('image/jpeg')
      end
    end

    context 'with filename with .png extension passed' do
      let(:subject) { @request.send(:mime_type, 'file .1.png') }

      it 'returns image/png string' do
        expect(subject).to eq('image/png')
      end
    end
  end
end