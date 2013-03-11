require 'forecast_io/configuration'
require 'forecast_io/version'

require 'hashie'
require 'multi_json'
require 'typhoeus'

module Forecast
  module IO
    extend Configuration

    class << self
      def forecast(latitude, longitude, options = {})
        forecast_url = "#{Forecast::IO.api_endpoint}/forecast/#{Forecast::IO.api_key}/#{latitude},#{longitude}"
        forecast_url += ",#{options[:time]}" if options[:time]

        forecast_response = Typhoeus::Request.get(forecast_url)
        if forecast_response.success?
          return Hashie::Mash.new(MultiJson.load(forecast_response.body))
        end
      end
    end
  end
end
