module Petstore
  class Client
    require 'faraday'
    require 'petstore/resources/pets'

    BASE_URI = 'http://petstore.swagger.wordnik.com:80/api'

    attr_reader :options, :conn

    def initialize(options = {})
      options[:timeout] ||= Petstore.timeout
      @options = options

      @conn = Faraday.new(:url => BASE_URI)
      @conn.options.timeout = @options[:timeout]
    end

    def pet
      Petstore::Resources::Pets.new(@conn)
    end
  end
  
end