module Petstore
  class Responce
    require 'json'
    require 'petstore/errors'

    include Petstore::Errors

    def initialize(status, body)
      @status = status
      @body = body

      parse_response
    end
    
    def parse_response
      case @status
      when 200
        JSON.parse(@body)
      when 404
        raise NotFound.new body[:message]
      when 405
        raise NotAllowed.new body[:message]
      when 400
        raise InvalidRequest.new body[:message]
      when 500
        raise ServerError.new body[:message]
      end
    end
    
  end
  
end