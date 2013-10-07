class Airbadger::AirbrakeLoader
  def self.load_as(airbrake_alias)
    new(airbrake_alias).load_aliased
  end

  def load_aliased
    without_recording_loaded_features do
      load_airbrake!
      load_airbrake_rails! if defined?(::Rails)
    end
    aliased_module.tap do
      preserve_namespaced_calls!
      remove_airbrake_from_global_namespace!
    end
  end

  private

  attr_reader :endpoint_alias

  def initialize(endpoint_alias)
    @endpoint_alias = endpoint_alias.sub(/^Airbrake$/, 'AirbrakeProxied')
  end

  def load_airbrake!
    require 'airbrake'
  end

  def load_airbrake_rails!
    require 'airbrake/rails/controller_methods'
    require 'airbrake/rails/javascript_notifier'
  end

  def aliased_module
    @aliased_module ||= Object.const_set(endpoint_alias, Airbrake)
  end

  def preserve_namespaced_calls!
    aliased_module.const_set('Airbrake', aliased_module)
  end

  def remove_airbrake_from_global_namespace!
    Object.send(:remove_const, 'Airbrake')
  end

  def without_recording_loaded_features
    feature_count = $LOADED_FEATURES.count
    yield
  ensure
    $LOADED_FEATURES.pop while feature_count < $LOADED_FEATURES.count
  end
end