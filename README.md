# forecast_io

[forecast.io](https://developer.darkskyapp.com/docs/v2) API wrapper in Ruby.

## Installation

`gem install forecast_io`

or in your `Gemfile`

```ruby
gem 'forecast_io'
```

## Usage

Make sure you require the library.

```ruby
require 'forecast_io'
```

You will need to set your API key before you can make requests to the [forecast.io](https://developer.darkskyapp.com/docs/v2) API.

```ruby
ForecastIO.configure do |configuration|
  configuration.api_key = 'this-is-your-api-key'
end
```

Alternatively:

```ruby
ForecastIO.api_key = 'this-is-your-api-key'
```

You can then make requests to the `ForecastIO.forecast(latitude, longitude, options = {})` method.

Valid options in the `options` hash are:

* `:time` - Unix time in seconds.
* `:params` - Query parameters that can contain the following:
  * `:jsonp` - JSONP callback.
  * `:units` - Return the API response in SI units, rather than the default Imperial units.
  * `:exclude` - "Exclude some number of data blocks from the API response. This is useful for reducing latency and saving cache space. [blocks] should be a comma-delimeted list (without spaces) of any of the following: currently, minutely, hourly, daily, alerts, flags." (via [v2 docs](https://developer.forecast.io/docs/v2#changelog))

Get the current forecast:

```ruby
forecast = ForecastIO.forecast(37.8267, -122.423)
```

Get the current forecast at a given time:

```ruby
forecast = ForecastIO.forecast(37.8267, -122.423, time: Time.new(2013, 3, 11).to_i)
```

Get the current forecast and use SI units:

```ruby
forecast = ForecastIO.forecast(37.8267, -122.423, params: { units: 'si' })
```

The `forecast(...)` method will return a response that you can interact with in a more-friendly way, such as:

```ruby
forecast = ForecastIO.forecast(37.8267, -122.423)
forecast.latitude
forecast.longitude
```

Please refer to the [forecast.io](https://developer.darkskyapp.com/docs/v2) API documentation for more information on the full response properties.

The HTTP requests are made with [Faraday](https://github.com/lostisland/faraday), which uses `Net::HTTP` by default. Changing the adapter is easy. We will use typhoeus as an example.

Make sure to include the typhoeus gem in your `Gemfile`:

```ruby
gem 'typhoeus'
```

```ruby
require 'typhoeus/adapters/faraday'

Faraday.default_adapter = :typhoeus
```

Alternatively:

```ruby
require 'typhoeus/adapters/faraday'

ForecastIO.connection = Faraday.new do |builder|
  builder.adapter :typhoeus
end
```

You can also customise the default parameters passed through on each API call:

```ruby
ForecastIO.default_params = {units: 'si'}

# or

ForecastIO.configure do |configuration|
  configuration.default_params = {units: 'si'}
end
```

## Contributing to forecast_io

* Check out the latest master to make sure the feature hasn't been implemented or the bug hasn't been fixed yet
* Check out the issue tracker to make sure someone already hasn't requested it and/or contributed it
* Fork the project
* Start a feature/bugfix branch
* Commit and push until you are happy with your contribution
* Make sure to add tests for it. This is important so I don't break it in a future version unintentionally.
* Please try not to mess with the Rakefile, version, or history. If you want to have your own version, or is otherwise necessary, that is fine, but please isolate to its own commit so I can cherry-pick around it.

## Copyright

Copyright (c) 2013 David Czarnecki. See LICENSE.txt for further details.
