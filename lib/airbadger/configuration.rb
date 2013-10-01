module Airbadger::Configuration
  def configure(service_name, &block)
    ::Airbadger::AirbrakeLoader.load_as(service_name).configure(&block)
  end
end