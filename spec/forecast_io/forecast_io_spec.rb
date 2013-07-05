require 'spec_helper'

describe ForecastIO do
  describe '.default_params' do
    it "defaults to an empty hash" do
      ForecastIO.default_params.should == {}
    end
  end

  describe '.forecast' do
    before :each do
      ForecastIO.api_key = 'this-is-an-api-key'
    end

    it 'should return a forecast for a given latitude, longitude' do
      VCR.use_cassette('forecast_for_latitude_longitude', record: :once) do
        forecast = ForecastIO.forecast('37.8267','-122.423')
        forecast.should_not be_nil
        forecast.latitude.should == 37.8267
        forecast.longitude.should == -122.423
        forecast.daily.size.should == 3
        forecast.alerts.should be_nil
      end
    end

    it 'should return a forecast for a given latitude, longitude and time' do
      VCR.use_cassette('forecast_for_latitude_longitude_and_time') do
        forecast = ForecastIO.forecast('37.8267','-122.423', time: Time.utc(2013, 3, 11, 4).to_i)
        forecast.should_not be_nil
        forecast.latitude.should == 37.8267
        forecast.longitude.should == -122.423
        forecast.daily.size.should == 1
        forecast.alerts.should be_nil
      end
    end

    it 'should return a forecast for a given latitude, longitude and query params' do
      VCR.use_cassette('forecast_for_latitude_longitude_and_query_params') do
        forecast = ForecastIO.forecast('37.8267','-122.423', params: {units: 'si'})
        forecast.should_not be_nil
        forecast.latitude.should == 37.8267
        forecast.longitude.should == -122.423
        forecast.daily.size.should == 3
        forecast.alerts.should be_nil
      end
    end

    context 'unit tests' do
      let(:faraday)  { double 'Faraday', get: response }
      let(:response) { double 'Response', success?: true, body: '{}' }

      before :each do
        stub_const 'Faraday', stub(new: faraday)

        ForecastIO.stub(api_key: 'abc123', connection: faraday)
      end

      context 'without default parameters' do
        before :each do
          ForecastIO.stub(default_params: {})
        end

        it "sends through a standard request" do
          faraday.should_receive(:get).with(
            'https://api.forecast.io/forecast/abc123/1.2,3.4', {}
          ).and_return(response)

          ForecastIO.forecast(1.2, 3.4)
        end

        it "sends through provided parameters" do
          faraday.should_receive(:get).with(
            'https://api.forecast.io/forecast/abc123/1.2,3.4', {units: 'si'}
          ).and_return(response)

          ForecastIO.forecast(1.2, 3.4, params: {units: 'si'})
        end
      end

      context 'with default parameters' do
        before :each do
          ForecastIO.stub(default_params: {units: 'si'})
        end

        it "sends through the default parameters" do
          faraday.should_receive(:get).with(
            'https://api.forecast.io/forecast/abc123/1.2,3.4', {units: 'si'}
          ).and_return(response)

          ForecastIO.forecast(1.2, 3.4)
        end

        it "sends through the merged parameters" do
          faraday.should_receive(:get).with(
            'https://api.forecast.io/forecast/abc123/1.2,3.4',
            {units: 'si', exclude: 'daily'}
          ).and_return(response)

          ForecastIO.forecast(1.2, 3.4, params: {exclude: 'daily'})
        end

        it "overwrites default parameters when appropriate" do
          faraday.should_receive(:get).with(
            'https://api.forecast.io/forecast/abc123/1.2,3.4',
            {units: 'imperial'}
          ).and_return(response)

          ForecastIO.forecast(1.2, 3.4, params: {units: 'imperial'})
        end
      end
    end
  end
end
