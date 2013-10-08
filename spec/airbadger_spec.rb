require 'spec_helper'

[Airbrake, Honeybadger].each do |error_api|
  describe error_api do
    ['#notify', '#notify_or_ignore'].each do |proxied_method|
      describe proxied_method do
        before :all do
          Airbrake.configure do |config|
            config.test_mode = true
          end
        end

        it 'proxies calls to Airbrake and Honeybadger' do
          proxied_method.sub!('#', '')

          error = Exception.new('Some serious shit went down')

          Airbrake.should_receive("#{proxied_method}_without_proxy").with(error)
          Honeybadger.should_receive("#{proxied_method}_without_proxy").with(error)

          error_api.send(proxied_method, error)
        end
      end
    end
  end
end