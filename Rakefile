# encoding: utf-8

require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
require 'rake'

require 'jeweler'
Jeweler::Tasks.new do |gem|
  # gem is a Gem::Specification... see http://docs.rubygems.org/read/chapter/20 for more options
  gem.name = "rspec_api_test"
  gem.homepage = "http://github.com/jayniz/rspec-api-test"
  gem.license = "MIT"
  gem.summary = %Q{Makes JSON-API integration testing easier with rspec}
  gem.description = %Q{Test a JSON-API using rspec and simple get/put/post/delete helpers}
  gem.email = "jannis@moviepilot.com"
  gem.authors = ["Jannis Hermanns"]
  # dependencies defined in Gemfile
end

Jeweler::RubygemsDotOrgTasks.new
require 'rspec/core'
require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec) do |spec|
  spec.pattern = FileList['spec/**/*_spec.rb']
end

RSpec::Core::RakeTask.new(:rcov) do |spec|
  spec.pattern = 'spec/**/*_spec.rb'
  spec.rcov = true
end

task :default => :spec
