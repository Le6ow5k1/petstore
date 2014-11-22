module Petstore
  class Request
    require 'active_model'
    include ActiveModel::Validations

    attr_reader :base_uri, :partial_path, :method, :params

    validates_presence_of :base_uri, :partial_path, :method

    def initialize(options = {})
      @base_uri = options[:base_uri]
      @partial_path = options[:partial_path]
      @method = options[:method]
      @params = options[:params]
    end
    
    
  end
  
end