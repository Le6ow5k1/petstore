module Petstore
  module Errors
    class ResponseError < StandardError
      def initialize(message)
        @message = message
      end

      def to_s
        @message
      end
    end

    class NotFound < ResponseError; end

    class InvalidRequest < ResponseError; end

    class NotAllowed < ResponseError; end

    class ServerError < ResponseError; end
  end
end