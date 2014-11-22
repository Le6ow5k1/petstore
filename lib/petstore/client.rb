module Petstore
  class Client
    attr_reader :options, :base_uri

    def initialize(options = {})
      options[:timeout] ||= Petstore.timeout

      @options = options
      @base_uri = 'http://petstore.swagger.wordnik.com:80/api'
    end
  end
  
end