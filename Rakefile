#!/usr/bin/env rake
# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)
require 'rake'
Simoom::Application.load_tasks

#
# BDD Rake setup
#
unless ENV['RAILS_ENV'] == 'production'

  require 'rspec/core/rake_task'

  desc "Run specs"
  RSpec::Core::RakeTask.new do |t|
    # t.rspec_opts = %w(--colour --fail-fast --format nested)
    t.rspec_opts = %w(--colour  --format nested)
    t.ruby_opts  = %w(-w)
  end

  Rake::Task[:default].prerequisites.clear
  task :default => :spec
end
