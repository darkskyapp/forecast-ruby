require 'forecast_io/configuration'
require 'forecast_io/version'

require 'hashie'
require 'multi_json'
require 'faraday'

module ForecastIO
  extend Configuration

  self.default_params = {}

  class << self
    # Retrieve the forecast for a given latitude and longitude.
    #
    # @param latitude [String] Latitude.
    # @param longitude [String] Longitude.
    # @param options [String] Optional parameters. Valid options are `:time` and `:params`.
    def forecast(latitude, longitude, options = {})
      forecast_url = "#{ForecastIO.api_endpoint}/forecast/#{ForecastIO.api_key}/#{latitude},#{longitude}"
      forecast_url += ",#{options[:time]}" if options[:time]

      forecast_response = get(forecast_url, options[:params])

      if forecast_response.success?
        return Hashie::Mash.new(MultiJson.load(forecast_response.body))
      end
    end

    # Build or get an HTTP connection object.
    def connection
      @connection ||= Faraday.new
    end

    # Set an HTTP connection object.
    #
    # @param connection Connection object to be used.
    def connection=(connection)
      @connection = connection
    end

    private

    def get(path, params = {})
      params = ForecastIO.default_params.merge(params || {})

      connection.get(path, params)
    end
  end
end
