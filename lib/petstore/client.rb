module Petstore
  class Client
    require 'faraday'
    require 'faraday_middleware'
    require 'petstore/resources/pets'

    DEFAULT_URI = 'http://petstore.swagger.wordnik.com:80/api'

    attr_reader :options, :conn

    def initialize(options = {})
      options[:timeout] ||= Petstore.timeout
      options[:uri] ||= DEFAULT_URI
      @options = options

      @conn = Faraday.new(:url => @options[:uri]) do |c|
        c.request :multipart
        c.request :url_encoded
        c.request :json

        c.options.timeout = @options[:timeout]
        c.adapter :net_http
      end
    end

    def pets
      Petstore::Resources::Pets.new(@conn)
    end
  end

end