require "bundler/gem_tasks"
require "rake/testtask"

# require 'rubygems'
# require 'bundler/setup'
# Bundler::GemHelper.install_tasks

# require 'appraisal'


Rake::TestTask.new(:test) do |t|
  t.libs << "test"
  t.libs << "lib"
  t.test_files = FileList["test/**/*_test.rb"]
  t.verbose = true
end

task :default => :test
