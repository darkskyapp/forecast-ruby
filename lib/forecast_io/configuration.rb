module ForecastIO
  module Configuration
    # Default API endpoint
    DEFAULT_FORECAST_IO_API_ENDPOINT = 'https://api.forecast.io'

    # Forecast API endpoint
    attr_writer :api_endpoint

    # API key
    attr_writer :api_key

    # Default parameters
    attr_accessor :default_params

    # Yield self to be able to configure ForecastIO with block-style configuration.
    #
    # Example:
    #
    #   ForecastIO.configure do |configuration|
    #     configuration.api_key = 'this-is-your-api-key'
    #   end
    def configure
      yield self
    end

    # API endpoint
    def api_endpoint
      @api_endpoint ||= DEFAULT_FORECAST_IO_API_ENDPOINT
    end

    # API key
    def api_key
      @api_key
    end
  end
end
