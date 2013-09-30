require 'spec_helper'

describe Airbadger::AirbrakeLoader do
  describe '.load_as' do
    it 'loads a new Airbrake singleton with the given name' do
      Airbadger::AirbrakeLoader.load_as('Errbit')
      Airbadger::AirbrakeLoader.load_as('Raygun')

      Errbit.should respond_to :notify
      Raygun.should respond_to :notify
      Errbit.should_not eq Raygun
    end
  end
end