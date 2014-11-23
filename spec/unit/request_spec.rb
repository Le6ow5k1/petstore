require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Petstore::Request do
  before(:each) do
    @conn = Faraday.new do |builder|
      builder.adapter :test do |stub|
        stub.get('/pet') { |env| [ 200, {}, 'dog' ]}
        stub.post('/pet') { |env| [ 200, {}, 'success' ]}
      end
    end
  end

  describe '#make' do
    context 'on Request instance with method option equals get' do
      subject { Petstore::Request.new(conn: @conn, partial_path: '/pet', method: :get) }

      it 'does a get request' do
        expect(subject.send(:get).body).to eq('dog')
      end
    end

    context 'on Request instance with method option equals post' do
      subject { Petstore::Request.new(conn: @conn, partial_path: '/pet', method: :post, params: {}) }

      it 'does a post request' do
        expect(subject.send(:post).body).to eq('success')
      end
    end
    
  end

end