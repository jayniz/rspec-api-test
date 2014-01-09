require 'rspec'
require 'rest-client'
require 'rspec_api_test/http_helpers'

RSpec.configure do |c|
  c.include(RSpecAPITest::HTTPHelpers)
end
