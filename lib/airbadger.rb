require 'airbadger/warning_suppression'
require 'airbadger/airbrake_loader'
require 'airbadger/configuration'

require 'airbadger/version'

module Airbadger
  extend Configuration

  def self.method_missing(method_name, *args, &block)
    if PROXIED_METHODS.include? method_name
      loaded_modules.each do |loaded_module|
        loaded_module.send(method_name, *args, &block)
      end
      return nil
    end
    super
  end

  private

  PROXIED_METHODS = [:notify, :notify_or_ignore]
end
