class Airbadger::AirbrakeLoader
  def self.load_as(airbrake_alias)
    load 'airbrake.rb'
    Object.const_set(airbrake_alias, Airbrake)
  end
end