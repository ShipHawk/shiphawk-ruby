# encoding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'shiphawk/version'

Gem::Specification.new do |spec|
  spec.name          = 'shiphawk'
  spec.version       = Shiphawk::VERSION::STRING
  spec.authors       = ['Robert Schmitt']
  spec.email         = ['bob.schmitt@shiphawk.com']
  spec.summary       = %q{Ruby bindings for the ShipHawk API}
  spec.description   = %q{ShipHawk, technology that delivers. See https://shiphawk.com for details.}
  spec.homepage      = 'https://github.com/ShipHawk/shiphawk-ruby'
  spec.license       = 'MIT'
  spec.require_paths = ['lib']

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_dependency 'faraday'
  spec.add_dependency 'faraday_middleware'
  spec.add_dependency 'faraday-conductivity'
  spec.add_dependency 'httpclient'
  spec.add_dependency 'typhoeus'
  spec.add_dependency 'em-http-request'

  spec.add_development_dependency 'bundler', '~> 1.9.4'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'webmock'
  spec.add_development_dependency 'vcr'
  spec.add_development_dependency 'pry'
end
