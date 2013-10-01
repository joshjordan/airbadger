class Airbadger::AirbrakeLoader
  extend Airbadger::WarningSuppression

  def self.load_as(airbrake_alias)
    old_loaded_features = $LOADED_FEATURES.count
    without_warnings do
      require 'airbrake'
    end
    Object.const_set(airbrake_alias, Airbrake).tap do
      Object.send(:remove_const, 'Airbrake')
      $LOADED_FEATURES.pop while old_loaded_features < $LOADED_FEATURES.count
    end
  end
end