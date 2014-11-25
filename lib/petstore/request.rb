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
      response = case @method
        when :get then get
        when :post then post
        when :delete then delete
        when :put then put
        when :patch then patch
        when :multipart_post then multipart_post
      end

      Petstore::Response.new(response.status, response.body).parse
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

    def multipart_post
      filename = @params[:file]
      payload = {file: Faraday::UploadIO.new("#{filename}", mime_type(filename))}

      @conn.post @partial_path, payload
    end

    def mime_type(filename)
      case filename
      when /\.gif$/i
        'image/gif'
      when /\.jpe?g/i
        'image/jpeg'
      when /\.png$/i
        'image/png'
      else
        'application/octet-stream'
      end
    end
  end

end