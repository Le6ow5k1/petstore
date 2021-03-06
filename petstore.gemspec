# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'petstore/version'

Gem::Specification.new do |spec|
  spec.name          = "petstore"
  spec.version       = Petstore::VERSION
  spec.authors       = ["Le6ow5k1"]
  spec.email         = ["le6oww5k1@gmail.com"]
  spec.summary       = %q{API client for the Pet Store sample API http://petstore.swagger.wordnik.com}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency 'activemodel'
  spec.add_dependency 'faraday', '= 0.9.0'
  spec.add_dependency 'faraday_middleware'
  spec.add_dependency 'json'

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "webmock"
  spec.add_development_dependency "cucumber"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "json_spec"
end
