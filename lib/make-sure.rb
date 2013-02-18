require 'rspec'
require 'make_sure/http_helpers'

RSpec.configure do |c|
  c.include(MakeSure::HTTPHelpers)
end
