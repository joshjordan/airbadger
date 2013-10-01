require 'rubygems'
require 'bundler'
begin
  Bundler.require(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
require 'rspec'

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'airbadger'

EXAMPLE_SERVICE_NAMES = [
  'Airbrake',
  'BasicAirbrake',
  'Errbit',
  'Raygun'
]

RSpec.configure do |config|
  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = 'random'

  config.before :each do
    EXAMPLE_SERVICE_NAMES.each do |service_name|
      Object.send(:remove_const, service_name) if Object.const_defined?(service_name)
    end
  end

  config.before :each do
    #todo: stop making the mistake I'm trying to correct; this should not be a singleton
    Airbadger.loaded_modules.reject! { true }
  end
end