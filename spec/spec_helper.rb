require 'rack/test'
require 'simplecov'

SimpleCov.start do
  minimum_coverage 100
  add_filter 'spec'
  add_filter 'vendor'
end

require_relative '../src/codebreaker_web'

Dir["#{Dir.pwd}/spec/support/**/*.rb"].sort.each { |f| require f }

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups
end