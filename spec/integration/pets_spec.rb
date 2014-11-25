require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe 'Petstore API' do
  before(:all) do
    API_PATH = 'http://petstore.swagger.wordnik.com:80/api'
    DEFAULT_HEADERS = {'Accept'=>'*/*',
                       'User-Agent'=>'Faraday v0.9.0'}
  end

  describe 'pet endpoint' do
    let(:pets) { Petstore::Client.new.pet }

    describe 'get method' do
      before do
        response_body = File.new("#{File.dirname(__FILE__)}/fixtures/get_pet.txt").read
        @expected_body = JSON.parse(response_body)

        @stub = stub_request(:get, "#{API_PATH}/pet/0")
          .with(headers: DEFAULT_HEADERS).to_return(status: 200, body: response_body)
        @response = pets.get(0)
      end

      it 'makes get request to /pet/:id' do
        expect(@stub).to have_been_requested
      end

      it 'returns successfull response' do
        expect(@response).to eq(@expected_body)
      end
    end

    describe 'create method' do
      before do
        response_body = File.new("#{File.dirname(__FILE__)}/fixtures/post_pet_success_body.txt").read
        @expected_body = JSON.parse(response_body)

        @stub = stub_request(:post, "#{API_PATH}/pet")
          .with(headers: DEFAULT_HEADERS.merge('Content-Type'=>'application/json'))
          .to_return(body: response_body, status: 200)
        @response = pets.create(id: 1)
      end

      it 'makes post request to /pet with right params' do
        expect(@stub).to have_been_requested
      end

      it 'returns successfull response' do
        expect(@response).to eq(@expected_body)
      end
    end

    describe 'delete method' do
      before do
        @stub = stub_request(:delete, "#{API_PATH}/pet/0")
          .with(headers: DEFAULT_HEADERS).to_return(body: 'no content', status: 200)
        @response = pets.delete(0)
      end

      it 'makes delete request to the /pet/:id' do
        expect(@stub).to have_been_requested
      end

      it 'returns empty response' do
        expect(@response).to eq(nil)
      end
    end

    it 'replaces existing pet' do
      response_body = File.new("#{File.dirname(__FILE__)}/fixtures/post_pet_success_body.txt").read
      expected_body = JSON.parse(response_body)

      stub = stub_request(:put, "#{API_PATH}/pet")
        .with(headers: DEFAULT_HEADERS.merge('Content-Type'=>'application/json'))
        .to_return(body: response_body, status: 200)
      response = pets.replace(id: 1)

      expect(stub).to have_been_requested
      expect(response).to eq(expected_body)
    end

    it 'updates existing pet' do
      response_body = File.new("#{File.dirname(__FILE__)}/fixtures/pet_1_put.txt").read
      expected_body = JSON.parse(response_body)

      stub = stub_request(:patch, "#{API_PATH}/pet/1")
        .with(headers: DEFAULT_HEADERS.merge('Content-Type'=>'application/json'))
        .to_return(body: response_body, status: 200)
      response = pets.update 1, status: 'pending'

      expect(stub).to have_been_requested
      expect(response).to eq(expected_body)
    end

    describe 'find_by_status method' do
      before do
        response_body = File.new("#{File.dirname(__FILE__)}/fixtures/pet_find_by_status.txt").read
        @expected_body = JSON.parse(response_body)

        @stub = stub_request(:get, "#{API_PATH}/pet/findByStatus")
          .with(headers: DEFAULT_HEADERS, query: {status: 'sold'})
          .to_return(body: response_body, status: 200)
        @response = pets.find_by_status :sold
      end

      it 'makes get request to /pet/findByStatus url with status param' do
        expect(@stub).to have_been_requested
      end

      it 'returns found pets' do
        expect(@response).to eq(@expected_body)
      end
    end

    describe 'find_by_tags method' do
      before do
        response_body = File.new("#{File.dirname(__FILE__)}/fixtures/pet_find_by_tags.txt").read
        @expected_body = JSON.parse(response_body)

        @stub = stub_request(:get, "#{API_PATH}/pet/findByTags")
          .with(headers: DEFAULT_HEADERS, query: {tags: 'cat,dog'})
          .to_return(body: response_body, status: 200)
        @response = pets.find_by_tags [:cat, :dog]
      end

      it 'makes get request to /pet/findByTags url with tags param' do
        expect(@stub).to have_been_requested
      end

      it 'returns found pets' do
        expect(@response).to eq(@expected_body)
      end
    end

    describe 'upload_image method' do
      before do
        file_like_object = double('file_like_object')
        allow(Faraday::UploadIO).to receive(:new).and_return(file_like_object)

        response_body = File.new("#{File.dirname(__FILE__)}/fixtures/upload_image_success.txt").read
        @expected_body = JSON.parse(response_body)

        @stub = stub_request(:post, "#{API_PATH}/pet/uploadImage")
          .with(headers: DEFAULT_HEADERS.merge('Content-Type'=>'application/x-www-form-urlencoded'),
                body: /.*/).to_return(status: 200, body: response_body)

        @response = pets.upload_image 'image'
      end

      it 'makes post request to /pet/uploadImage' do
        expect(@stub).to have_been_requested
      end

      it 'returns successfull response' do
        expect(@response).to eq(@expected_body)
      end
    end
  end

end