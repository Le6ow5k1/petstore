require 'active_support'
require 'active_support/core_ext'

Given(/^a petstore api endpoint$/) do
  create_petstore
end

When(/^I call "(.+)" method on "(.+)" resource with (\d+|\w+)$/) do |method, resource, params|
  @response = @petstore.send(resource.to_sym).send(method.to_sym, params)
end

When(/^I call "(.*?)" method on "(.*?)" resource with (array|hash):$/) do |method, resource, type, table|
  params = case type
  when 'array'
    table.raw.flatten
  when 'hash'
    table.raw.to_h
  end
  @response = @petstore.send(resource.to_sym).send(method.to_sym, params)
end

When(/^response at "(.+)" should be (.+)$/) do |key, value|
  response[key].to_s.should eql(value)
end

Then(/^response should have (\d+) entr(?:y|ies)$/) do |number|
  response.size.should eql(number.to_i)
end

When(/^response should be\s?(?:a|an)? (hash|array|nil)$/) do |type|
  case type
  when 'array'
    response.should be_an(Array)
  when 'hash'
    response.should be_a(Hash)
  when 'hash'
    response.should be_nil
  end
end

def create_petstore
  @petstore = Petstore.new
end

def response
  @response
end