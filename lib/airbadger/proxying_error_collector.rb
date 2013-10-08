module Airbadger::ProxyingErrorCollector
  PROXY_METHODS = [:notify, :notify_or_ignore]

  def self.extend_object(error_collector)
    class << error_collector
      Airbadger::ProxyingErrorCollector::PROXY_METHODS.each do |method_name|
        define_method "#{method_name}_with_proxy" do |*args|
          Airbadger::ERROR_COLLECTORS.each do |proxied_collector|
            proxied_collector.send("#{method_name}_without_proxy", *args)
          end
        end

        alias_method "#{method_name}_without_proxy", method_name
        alias_method method_name, "#{method_name}_with_proxy"
      end
    end
  end
end