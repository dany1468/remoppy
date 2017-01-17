require 'bundler/gem_tasks'
require 'rspec/core/rake_task'
require "rake/testtask"

desc 'Run test_unit based test'
Rake::TestTask.new do |t|
  t.libs << "test"
  t.libs << "lib"
  t.test_files = Dir["test/**/test_*.rb"]
  t.verbose = true
  t.warning = true
end

RSpec::Core::RakeTask.new(:spec)

task default: :test
