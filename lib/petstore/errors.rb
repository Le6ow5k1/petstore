module Petstore
  module Errors
    class ResponseError
      attr_reader :code, :message

      def initialize(message)
        @message = message
        @code = @@code
      end

      def self.set_code(code)
        @@code = code
      end
    end

    class NotFound < ResponseError
      set_code 404
    end

    class InvalidRequest < ResponseError
      set_code 400
    end

    class NotAllowed < ResponseError
      set_code 405
    end

    class ServerError < ResponseError
      set_code 500
    end
  end
end