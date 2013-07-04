require 'rspec'
require 'forecast_io'

Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}

require 'vcr'
require 'typhoeus/adapters/faraday'

VCR.configure do |c|
  c.cassette_library_dir = 'spec/cassettes'
  c.hook_into :typhoeus
  c.allow_http_connections_when_no_cassette = false
end

Faraday.default_adapter = :typhoeus

RSpec.configure do |config|
  config.before(:each) do
    ForecastIO.api_key = nil
  end
end
