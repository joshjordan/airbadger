class Airbadger::AirbrakeLoader
  def self.load_as(airbrake_alias)
    airbrake_alias = 'AirbrakeProxied' if airbrake_alias == 'Airbrake'
    old_loaded_features = $LOADED_FEATURES.count
    require 'airbrake'
    Object.const_set(airbrake_alias, Airbrake).tap do |loaded_module|
      loaded_module.const_set('Airbrake', loaded_module)
      Object.send(:remove_const, 'Airbrake')
      $LOADED_FEATURES.pop while old_loaded_features < $LOADED_FEATURES.count
    end
  end
end