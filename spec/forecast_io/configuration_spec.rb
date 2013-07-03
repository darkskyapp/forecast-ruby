require 'spec_helper'

describe ForecastIO::Configuration do
  describe '.configure' do
    it 'should have default attributes' do
      ForecastIO.configure do |configuration|
        configuration.api_endpoint.should eql(ForecastIO::Configuration::DEFAULT_FORECAST_IO_API_ENDPOINT)
        configuration.api_key.should be_nil
      end
    end
  end
end
