module Petstore
  class Request
    require 'active_model'

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
        get
      when :post
        post
      when :delete
        delete
      when :put
        put
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

  end
  
end