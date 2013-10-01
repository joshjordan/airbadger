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
  end
end