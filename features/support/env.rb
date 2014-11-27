require 'cucumber/formatter/unicode' # Remove this line if you don't want Cucumber Unicode support
require 'pry'
require 'json_spec/cucumber'

require 'petstore'

module Petstore
  class Client
    def initialize(opts = {})
      @conn = Faraday.new do |builder|
        builder.adapter :test do |stub|
          stub.get('/pet/1') { |env| [200, {}, "{\"id\": 1}"] }
          stub.get('/pet/findByStatus?status=sold') { |env| [200, {}, "[{\"id\": 1}, {\"id\": 2}]"] }
          stub.get('/pet/findByTags?tags=tag1%2Ctag2') { |env| [200, {}, "[{\"id\": 1}]"] }
          stub.post('/pet', {"id"=>"1", "name"=>"Rex"}) { |env| [200, {}, "{\"code\": 200, \"message\": \"SUCCESS\"}"] }
          stub.put('/pet', {"id"=>"2", "name"=>"RinTinTin"}) { |env| [200, {}, "{\"id\": 2, \"name\": \"RinTinTin\"}"] }
          stub.delete('/pet/1') { |env| [200, {}, "no content"] }
        end
      end
    end
  end
end