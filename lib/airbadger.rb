require 'airbadger/warning_suppression'
require 'airbadger/airbrake_loader'
require 'airbadger/configuration'

require 'airbadger/version'

module Airbadger
  def self.configure(&block)
    configuration.instance_eval(&block)
    configuration.setup_proxy!
  end

  def self.method_missing(method_name, *args, &block)
    if PROXIED_METHODS.include? method_name
      configuration.loaded_endpoints.each do |endpoint|
        endpoint.send(method_name, *args, &block)
      end
      return nil
    end
    super
  end

  private

  PROXIED_METHODS = [:notify, :notify_or_ignore]

  def self.configuration
    @configuration ||= Configuration.new
  end
end
