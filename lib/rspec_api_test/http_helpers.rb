require 'json'
require 'active_support/core_ext/hash'
require 'rspec_api_test/example_methods'
require 'rspec_api_test/example_group_methods'

class RSpecAPITest
  def self.config=(config)
    @config = config
  end

  def self.config
    @config ||= {}
  end

  module HTTPHelpers
  end
end
