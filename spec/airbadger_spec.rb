require 'spec_helper'

describe Airbadger do
  ['#notify', '#notify_or_ignore'].each do |proxied_method|
    describe proxied_method do
      it 'proxies calls to all configured modules' do
        proxied_method.sub!('#', '')

        Airbadger.configure do
          configure_service :raygun do |config|
            config.test_mode = true
          end
          configure_service :errbit do |config|
            config.test_mode = true
          end
        end

        error = Exception.new('Some serious shit went down')

        Raygun.should_receive(proxied_method).with(error)
        Errbit.should_receive(proxied_method).with(error)

        Airbadger.send(proxied_method, error)
      end
    end
  end

  it 'proxies calls to Airbrake to all loaded modules' do
    Airbadger.configure do
      configure_service :raygun do |config|
        config.test_mode = true
      end
      configure_service :errbit do |config|
        config.test_mode = true
      end
    end

    error = Exception.new('Some serious shit went down')

    Raygun.should_receive(:notify).with(error)
    Errbit.should_receive(:notify).with(error)

    Airbrake.notify(error)
  end

  it 'proxies calls to Honeybadger' do
    Airbadger.configure do 
      configure_service :raygun do |config|
        config.test_mode = true
      end
      configure_service :honeybadger do |config|
        config.ignore_only = []
      end
    end

    error = Exception.new('Some serious shit went down')

    Raygun.should_receive(:notify).with(error)
    Honeybadger.should_receive(:notify).with(error)

    Airbadger.notify(error)
  end
end