# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)

require 'forecast_io/version'

Gem::Specification.new do |s|
  s.name        = "forecast_io"
  s.version     = ForecastIO::VERSION
  s.authors     = ["David Czarnecki"]
  s.email       = ["me@davidczarnecki.com"]
  s.homepage    = "https://github.com/darkskyapp/forecast-ruby"
  s.summary     = %q{forecast.io API wrapper in Ruby}
  s.description = %q{forecast.io API wrapper in Ruby}

  s.rubyforge_project = "forecast_io"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency('faraday')
  s.add_dependency('multi_json')
  s.add_dependency('hashie')

  s.add_development_dependency('rake')
  s.add_development_dependency('rspec')
  s.add_development_dependency('vcr')
  s.add_development_dependency('typhoeus')
end
