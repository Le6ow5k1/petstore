module Petstore
  class Request
    require 'active_model'
    require 'petstore/response'

    include ActiveModel::Validations

    attr_reader :conn, :partial_path, :method, :params

    validates_presence_of :conn, :partial_path, :method

    def initialize(options = {})
      @conn = options[:conn]
      @partial_path = options[:partial_path]
      @method = options[:method]
      @params = options[:params]
    end
    
    def make
      case @method
      when :get
        response = get
        Petstore::Response.new(response.status, response.body).parse
      when :post
        response = post
        Petstore::Response.new(response.status, response.body).parse
      when :delete
        response = delete
        Petstore::Response.new(response.status, response.body).parse
      when :put
        response = put
        Petstore::Response.new(response.status, response.body).parse
      when :patch
        response = patch
        Petstore::Response.new(response.status, response.body).parse
      end
    end

    private

    def get
      @conn.get @partial_path, @params
    end

    def post
      @conn.post @partial_path, @params do |req|
        req.headers['Content-Type'] = 'application/json'
      end
    end

    def delete
      @conn.delete @partial_path, @params
    end

    def put
      @conn.put @partial_path, @params do |req|
        req.headers['Content-Type'] = 'application/json'
      end
    end

    def patch
      @conn.patch @partial_path, @params do |req|
        req.headers['Content-Type'] = 'application/json'
      end
    end

  end
  
end