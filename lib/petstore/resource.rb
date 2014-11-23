module Petstore
  class Resource
    require 'active_model'
    require 'petstore/request'

    include ActiveModel::Validations

    attr_accessor :path
    attr_reader :conn

    validates_presence_of :path, :conn

    def initialize(conn)
      @conn ||= conn
    end

    def self.set_path(path)
      @@path = path
    end
    
    def get(path_part = nil, params = nil)
      Petstore::Request.new(conn: conn, partial_path: partial_path(path_part),
                            method: :get, params: params).make
    end

    def create(path_part = nil, data)
      Petstore::Request.new(conn: conn, partial_path: partial_path(path_part),
                            method: :post, params: data).make
    end

    def delete(path_part = nil)
      Petstore::Request.new(conn: conn, partial_path: partial_path(path_part),
                            method: :delete).make
    end

    def replace(path_part = nil, data)
      Petstore::Request.new(conn: conn, partial_path: partial_path(path_part),
                            method: :put, params: data).make
    end

    def update(path_part = nil, data)
      Petstore::Request.new(conn: conn, partial_path: partial_path(path_part),
                            method: :patch, params: data).make
    end

    private

    def partial_path(path_part)
      path_part ? "#{@@path}/#{path_part}" : "#{@@path}"
    end
  end
        
end