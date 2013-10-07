require 'spec_helper'

describe Airbadger::AirbrakeLoader do
  include Airbadger::WarningSuppression

  describe '.load_as' do
    it 'loads a new Airbrake singleton with the given name' do
      without_warnings do
        described_class.load_as('Errbit')
        described_class.load_as('Raygun')
      end

      Errbit.should respond_to :notify
      Raygun.should respond_to :notify
      Errbit.should_not eq Raygun
    end

    it 'produces endpoints singletons capable of receiving error data' do
      without_warnings do
        described_class.load_as('Errbit')
      end
      Errbit.configure do |config|
        config.test_mode = true
      end

      now = DateTime.now.to_s
      Errbit.notify(Exception.new(now))

      Errbit.sender.last_notice.should include(now)
    end

    it 'eager-loads Rails extensions when Rails is running' do
      Rails = Module.new
      without_warnings { described_class.load_as('Errbit') }

      defined?(Errbit::Rails::ControllerMethods).should be_true
      defined?(Errbit::Rails::JavascriptNotifier).should be_true

      Object.send(:remove_const, 'Rails')
    end

    it 'does not load Rails extensions when Rails is not running' do
      without_warnings { described_class.load_as('Errbit') }

      defined?(Errbit::Rails::ControllerMethods).should be_false
      defined?(Errbit::Rails::JavascriptNotifier).should be_false
    end
  end
end