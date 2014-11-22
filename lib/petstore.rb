require "petstore/version"
require "petstore/client"

module Petstore
  class << self
    attr_accessor :timeout

    def new(options = {})
      Client.new(options)
    end

    # ```ruby
    # Petstore.configure do |config|
    #   config.timeout = 1000
    # end
    # ```
    def configure
      yield self
      true
    end
  end

end
