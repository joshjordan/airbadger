require 'spec_helper'

describe Airbadger::Configuration do
  describe '#endpoint' do
    it 'proxies the configuration block to a named Airbrake singleton' do
      subject.endpoint :BasicAirbrake do |config|
        config.test_mode = true
      end

      subject.endpoint :Errbit do |config|
        config.test_mode = true
        config.host = 'errbit.example.com'
      end

      BasicAirbrake.configuration.host.should eq 'api.airbrake.io'
      Errbit.configuration.host.should eq 'errbit.example.com'
    end

    it 'accepts snake-cased service names and produces constants with proper class names' do
      subject.endpoint :basic_airbrake do |config|
        config.test_mode = true
      end

      defined?(BasicAirbrake).should be_true
    end

    it 'rewrites the name "Airbrake" to "AirbrakeProxied" to avoid collisions' do
      subject.endpoint :airbrake do |config|
        config.test_mode = true
      end

      defined?(Airbrake).should be_false
      defined?(AirbrakeProxied).should be_true
    end

    it 'supports Honeybadger configuration from the Honeybadger gem rather than the Airbrake gem' do
      Airbadger::AirbrakeLoader.should_receive(:load_as).never

      subject.endpoint :honeybadger do |config|
        config.ignore_only = []
      end

      defined?(Honeybadger).should be_true
    end
  end
end