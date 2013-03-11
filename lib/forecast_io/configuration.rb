module Forecast
  module IO
    module Configuration
      DEFAULT_FORECAST_IO_API_ENDPOINT = 'https://api.forecast.io'

      # Forecast API endpoint
      attr_writer :api_endpoint

      # API key
      attr_writer :api_key

      def configure
        yield self
      end

      def api_endpoint
        @api_endpoint ||= DEFAULT_FORECAST_IO_API_ENDPOINT
      end

      def api_key
        @api_key
      end
    end
  end
end