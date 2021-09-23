require_relative '../src/codebreaker_web'
SimpleCov.start do
  minimum_coverage 100
  add_filter 'spec'
  add_filter 'vendor'
end
