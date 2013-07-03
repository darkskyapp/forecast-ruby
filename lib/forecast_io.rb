require 'forecast_io/configuration'

require 'hashie'
require 'multi_json'
require 'faraday'

module Forecast
  module IO
    extend Configuration

    class << self
      # Retrieve the forecast for a given latitude and longitude.
      #
      # @param latitude [String] Latitude.
      # @param longitude [String] Longitude.
      # @param options [String] Optional parameters. Valid options are `:time` and `:params`.
      def forecast(latitude, longitude, options = {})
        forecast_url = "#{Forecast::IO.api_endpoint}/forecast/#{Forecast::IO.api_key}/#{latitude},#{longitude}"
        forecast_url += ",#{options[:time]}" if options[:time]

        forecast_response = if options[:params]
          connection.get(forecast_url, options[:params])
        else
          connection.get(forecast_url)
        end

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
    end
  end
end
