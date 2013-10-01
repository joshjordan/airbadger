require 'spec_helper'

describe Airbadger::AirbrakeLoader do
  include Airbadger::WarningSuppression

  describe '.load_as' do
    it 'loads a new Airbrake singleton with the given name' do
      without_warnings do
        Airbadger::AirbrakeLoader.load_as('Errbit')
        Airbadger::AirbrakeLoader.load_as('Raygun')
      end

      Errbit.should respond_to :notify
      Raygun.should respond_to :notify
      Errbit.should_not eq Raygun
    end
  end
end