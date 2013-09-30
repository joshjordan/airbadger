require 'spec_helper'

describe Airbadger::WarningSuppression do
  include Airbadger::WarningSuppression

  describe '#without_warnings' do
    before :each do
      @old_version = Airbadger::VERSION
    end

    let! :error_stream do
      $stderr = StringIO.new
    end
    
    it 'executes the block and does not emit warnings into the stderr stream' do
      without_warnings do
        Airbadger::VERSION = 42
      end

      Airbadger::VERSION.should eq 42
      error_stream.string.should be_empty
    end

    it 'resumes emitting warnings into the stderr stream after the block' do
      without_warnings do
        Airbadger::VERSION = 42
      end

      Airbadger::VERSION = 43

      error_stream.string.should_not be_empty
    end

    after :each do
      Airbadger::VERSION = @old_version
      $stderr = STDERR
    end
  end
end