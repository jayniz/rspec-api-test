require 'rspec'
require 'rspec_api_test/http_helpers'

RSpec.configure do |c|
  c.extend(RSpecAPITest::HTTPHelpers::ExampleGroupMethods)
  c.include(RSpecAPITest::HTTPHelpers::ExampleMethods)
end
