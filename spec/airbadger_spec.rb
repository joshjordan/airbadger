require 'spec_helper'

describe Airbadger do
  ['#notify', '#notify_or_ignore'].each do |proxied_method|
    describe proxied_method do
      it 'proxies calls to all configured modules' do
        proxied_method.sub!('#', '')

        Airbadger.configure :raygun do |config|
          config.test_mode = true
        end

        Airbadger.configure :errbit do |config|
          config.test_mode = true
        end

        error = Exception.new('Some serious shit went down')

        Raygun.should_receive(proxied_method).with(error)
        Errbit.should_receive(proxied_method).with(error)

        Airbadger.send(proxied_method, error)
      end
    end
  end
end