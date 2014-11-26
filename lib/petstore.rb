require 'petstore/version'
require 'petstore/client'
require 'petstore/errors'

module Petstore
  include Errors

  class << self
    attr_accessor :timeout

    def new(options = {})
      Client.new(options)
    end

    def configure
      yield self
      true
    end
  end
end
