require 'bundler/gem_tasks'

desc 'Open an irb session preloaded with Airbadger'
task :console do
  sh 'irb -rubygems -I lib -r airbadger.rb -I spec -r spec_helper.rb'
end

require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec)
task :default => :spec
