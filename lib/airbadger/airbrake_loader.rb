class Airbadger::AirbrakeLoader
  extend Airbadger::WarningSuppression

  def self.load_as(airbrake_alias)
    airbrake_alias = airbrake_alias.to_s.split('_').collect{ |str| str[0] = str[0].upcase; str }.join
    airbrake_alias = 'AirbrakeProxied' if airbrake_alias == 'Airbrake'
    old_loaded_features = $LOADED_FEATURES.count
    without_warnings do
      #what about duping the Airbrake module instead of doing this repeated require thing?
      require 'airbrake'
    end
    Object.const_set(airbrake_alias, Airbrake).tap do |loaded_module|
      loaded_module.const_set('Airbrake', loaded_module)
      Object.send(:remove_const, 'Airbrake')
      $LOADED_FEATURES.pop while old_loaded_features < $LOADED_FEATURES.count
    end
  end
end