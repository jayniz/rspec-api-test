require 'rspec'
require 'rspec_api_test/http_helpers'

RSpec.configure do |c|
  c.include(RSpecAPITest::HTTPHelpers)
end
