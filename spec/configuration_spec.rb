require 'spec_helper'

describe Airbadger::Configuration do
  describe '#configure_service' do
    it 'proxies the configuration block to a named Airbrake singleton' do
      subject.configure_service :BasicAirbrake do |config|
        config.test_mode = true
      end

      subject.configure_service :Errbit do |config|
        config.test_mode = true
        config.host = 'errbit.example.com'
      end

      BasicAirbrake.configuration.host.should eq 'api.airbrake.io'
      Errbit.configuration.host.should eq 'errbit.example.com'
    end

    it 'accepts snake-cased service names and produces constants with proper class names' do
      subject.configure_service :basic_airbrake do |config|
        config.test_mode = true
      end

      defined?(BasicAirbrake).should be_true
    end

    it 'rewrites the name "Airbrake" to "AirbrakeProxied" to avoid collisions' do
      subject.configure_service :airbrake do |config|
        config.test_mode = true
      end

      defined?(Airbrake).should be_false
      defined?(AirbrakeProxied).should be_true
    end

    it 'supports Honeybadger configuration from the Honeybadger gem rather than the Airbrake gem' do
      Airbadger::AirbrakeLoader.should_receive(:load_as).never

      subject.configure_service :honeybadger do |config|
        config.ignore_only = []
      end

      defined?(Honeybadger).should be_true
    end
  end
end