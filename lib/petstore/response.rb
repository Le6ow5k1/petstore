module Petstore
  class Response
    require 'json'
    require 'petstore/errors'

    include Petstore::Errors

    def initialize(status, body)
      @status = status
      @body = body
    end

    def parse
      parse_body

      case @status
      when 200
        @body
      when 404
        raise NotFound.new body_message
      when 405
        raise NotAllowed.new body_message
      when 400
        raise InvalidRequest.new body_message
      when 500
        raise ServerError.new body_message
      end
    end

    private

    def parse_body
      begin
        @body = JSON.parse(@body)
      rescue JSON::ParserError
        @body = nil
      end
    end

    def body_message
      @body['message'] if @body && @body.is_a?(Hash)
    end

  end

end
