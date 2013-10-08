require 'airbadger/version'

require 'airbadger/proxying_error_collector'

require 'airbrake'
require 'honeybadger'

module Airbadger
  ERROR_COLLECTORS = [Airbrake, Honeybadger]

  ERROR_COLLECTORS.each do |error_collector|
    error_collector.extend(ProxyingErrorCollector)
  end
end
