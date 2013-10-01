class Airbadger::Configuration
  include Airbadger::WarningSuppression

  def configure_service(service_name, &block)
    service_name_for_check = service_name.to_s.split('_').collect{ |str| str[0] = str[0].upcase; str }.join
    loaded_module = if service_name_for_check != 'Honeybadger'
      ::Airbadger::AirbrakeLoader.load_as(service_name)
    else
      without_warnings { require 'honeybadger' }
      Honeybadger
    end.tap do |loaded_module|
      loaded_modules.push(loaded_module)
    end.configure(&block)
  end

  def setup_proxy!
    Object.const_set('Airbrake', Airbadger)
  end

  def loaded_modules
    @loaded_modules ||= []
  end
end