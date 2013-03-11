require 'spec_helper'

describe Forecast::IO::Configuration do
  describe '.configure' do
    it 'should have default attributes' do
      Forecast::IO.configure do |configuration|
        configuration.api_endpoint.should eql(Forecast::IO::Configuration::DEFAULT_FORECAST_IO_API_ENDPOINT)
        configuration.api_key.should be_nil
      end
    end
  end
end