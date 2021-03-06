$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
gem 'minitest', '~> 5.8'
require 'minitest/autorun'
require 'minitest/pride'
require 'vcr'

VCR.configure do |config|
  config.cassette_library_dir = "test/fixtures/vcr_cassettes"
  config.hook_into :webmock
  config.allow_http_connections_when_no_cassette = true
end