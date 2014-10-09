require 'spec_helper'

describe ForecastIO::Configuration do
  describe '.configure' do
    it 'should have default attributes' do
      ForecastIO.configure do |configuration|
        expect(configuration.api_endpoint).to eq(ForecastIO::Configuration::DEFAULT_FORECAST_IO_API_ENDPOINT)
        expect(configuration.api_key).to be_nil
      end
    end
  end
end
