require 'spec_helper'

describe Airbadger::Configuration do
  include Airbadger::Configuration

  describe '#configure' do
    it 'proxies the configuration block to a named Airbrake singleton' do
      configure :BasicAirbrake do |config|
        config.test_mode = true
      end

      configure :Errbit do |config|
        config.test_mode = true
        config.host = 'errbit.example.com'
      end

      BasicAirbrake.configuration.host.should eq 'api.airbrake.io'
      Errbit.configuration.host.should eq 'errbit.example.com'
    end

    it 'accepts snake-cased service names and produces constants with proper class names' do
      configure :basic_airbrake do |config|
        config.test_mode = true
      end

      defined?(BasicAirbrake).should be_true
    end

    it 'rewrites the name "Airbrake" to "AirbrakeProxied" to avoid collisions' do
      configure :airbrake do |config|
        config.test_mode = true
      end

      defined?(Airbrake).should be_false
      defined?(AirbrakeProxied).should be_true
    end
  end
end