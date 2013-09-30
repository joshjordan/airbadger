require 'spec_helper'

describe Airbadger::AirbrakeLoader do
  describe '.load_as' do
    it 'loads a new Airbrake singleton with the given name' do
      Airbadger::AirbrakeLoader.load_as('Errbit')

      Errbit.should respond_to :notify
    end
  end
end