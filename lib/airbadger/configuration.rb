module Airbadger::Configuration
  def configure(service_name, &block)
    ::Airbadger::AirbrakeLoader.load_as(service_name).configure(&block)
  end

  def setup_proxy!
    Object.const_set('Airbrake', Airbadger)
  end
end