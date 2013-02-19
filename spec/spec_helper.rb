$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'bundler'
Bundler.require
require 'vcr_setup'
require 'rspec_api_test'

require File.expand_path("../../lib/rspec_api_test/http_helpers", __FILE__)

# Requires supporting files with custom matchers and macros, etc,
# in ./support/ and its subdirectories.
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}

RSpec.configure do |config|
  config.before(:suite) do
    RSpecAPITest.config = nil
  end
end


