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
  task :default => :spec
end
