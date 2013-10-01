class Airbadger::Configuration
  include Airbadger::WarningSuppression

  def endpoint(service_name, &block)
    load_endpoint(service_name).configure(&block)
  end

  def setup_proxy!
    Object.const_set('Airbrake', Airbadger)
  end

  def loaded_endpoints
    @loaded_modules ||= []
  end

  private

  ENDPOINT_LOADERS = Hash.new(::Airbadger::AirbrakeLoader.method(:load_as)).merge({
    'Honeybadger' => Proc.new do
      require 'honeybadger'
      Honeybadger
    end
  })

  def load_endpoint(service_name)
    service_name = ghetto_classify(service_name)
    without_warnings do
      ENDPOINT_LOADERS[service_name].call(service_name)
    end.tap(&loaded_endpoints.method(:push))
  end

  def ghetto_classify(snake_cased)
    snake_cased.to_s.split('_').collect{ |str| str[0] = str[0].upcase; str }.join
  end
end