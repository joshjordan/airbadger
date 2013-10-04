# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'airbadger/version'

Gem::Specification.new do |spec|
  spec.name          = "airbadger"
  spec.version       = Airbadger::VERSION
  spec.authors       = ["Josh Jordan"]
  spec.email         = ["josh.jordan@gmail.com"]
  spec.description   = %q{To ease the transition when trying out a new error monitoring service, Airbadger can report errors to multiple Airbrake API-compatible endpoints, such as Errbit and Raygun. Honeybadger is also supported.}
  spec.summary       = %q{Reports errors to multiple Airbrake-compatible endpoints}
  spec.homepage      = "http://github.com/joshjordan/airbadger"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency 'airbrake', '< 3.2'
  spec.add_dependency 'honeybadger', '< 1.9'

  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'rake', '~> 10.1'
  spec.add_development_dependency 'pry', '~> 0.9'
  spec.add_development_dependency 'rspec', '~> 2.14'
end
