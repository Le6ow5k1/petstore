require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe 'Petstore API' do
  before(:all) do
    API_PATH = 'http://petstore.swagger.wordnik.com:80/api'
    DEFAULT_HEADERS = {'Accept'=>'*/*',
                       'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
                       'User-Agent'=>'Faraday v0.9.0'}
  end

  context '/pet endpoint' do
    let(:pets) { Petstore::Client.new.pet }

    it 'gets pet by id' do
      get_pet_0 = File.new("#{File.dirname(__FILE__)}/responses/get_pet_0.txt").read
      stub = stub_request(:get, "#{API_PATH}/pet/0")
        .with(:headers => DEFAULT_HEADERS).to_return(get_pet_0)
      response = pets.get(0)

      expect(stub).to have_been_requested
    end

    it 'creates new pet' do
      response_body = File.new("#{File.dirname(__FILE__)}/responses/post_pet_success_body.txt").read
      expected_body = JSON.parse(response_body)
      
      stub = stub_request(:post, "#{API_PATH}/pet")
        .with(:headers => DEFAULT_HEADERS.merge('Content-Type'=>'application/json'))
        .to_return(body: response_body, status: 200)
      response = pets.create(id: 1)

      expect(stub).to have_been_requested
      expect(response).to eq(expected_body)
    end

    it 'deletes pet from the store' do
      stub = stub_request(:delete, "#{API_PATH}/pet/0")
        .with(:headers => DEFAULT_HEADERS).to_return(body: 'no content', status: 200)
      response = pets.delete(0)

      expect(stub).to have_been_requested
      expect(response).to eq(nil)
    end

    it 'replaces existing pet' do
      response_body = File.new("#{File.dirname(__FILE__)}/responses/post_pet_success_body.txt").read
      expected_body = JSON.parse(response_body)

      stub = stub_request(:put, "#{API_PATH}/pet")
        .with(:headers => DEFAULT_HEADERS.merge('Content-Type'=>'application/json'))
        .to_return(body: response_body, status: 200)
      response = pets.replace(id: 1)

      expect(stub).to have_been_requested
      expect(response).to eq(expected_body)
    end

    it 'updates existing pet' do
      response_body = File.new("#{File.dirname(__FILE__)}/responses/pet_1_put.txt").read
      expected_body = JSON.parse(response_body)

      stub = stub_request(:patch, "#{API_PATH}/pet/1")
        .with(:headers => DEFAULT_HEADERS.merge('Content-Type'=>'application/json'))
        .to_return(body: response_body, status: 200)
      response = pets.update 1, status: 'pending'

      expect(stub).to have_been_requested
      expect(response).to eq(expected_body)
    end

    it 'finds pet by status' do
      response_body = File.new("#{File.dirname(__FILE__)}/responses/pet_find_by_status.txt").read
      expected_body = JSON.parse(response_body)

      stub = stub_request(:get, "#{API_PATH}/pet/findByStatus")
        .with(:headers => DEFAULT_HEADERS, :query => {:status => 'sold'})
        .to_return(body: response_body, status: 200)
      response = pets.find_by_status :sold

      expect(stub).to have_been_requested
      expect(response).to eq(expected_body)
    end

    it 'finds pet by tags' do
      response_body = File.new("#{File.dirname(__FILE__)}/responses/pet_find_by_tags.txt").read
      expected_body = JSON.parse(response_body)

      stub = stub_request(:get, "#{API_PATH}/pet/findByTags")
        .with(:headers => DEFAULT_HEADERS, :query => {:tags => 'cat,dog'})
        .to_return(body: response_body, status: 200)
      response = pets.find_by_tags [:cat, :dog]

      expect(stub).to have_been_requested
      expect(response).to eq(expected_body)
    end
  end
  
end