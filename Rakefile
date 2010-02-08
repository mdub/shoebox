require File.expand_path("../.bundle/environment", __FILE__)

require 'rake'
require 'rake/testtask'
require 'rake/rdoctask'

require(File.join(File.dirname(__FILE__), 'config', 'boot'))

require 'tasks/rails'

task :bc => ["db:migrate", "spec"]
