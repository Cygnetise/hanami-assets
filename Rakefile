# frozen_string_literal: true

require "rake"
require "bundler/gem_tasks"
require "rspec/core/rake_task"
require "hanami/devtools/rake_tasks"

RSpec::Core::RakeTask.new(:spec)

require "rubocop/rake_task"

RuboCop::RakeTask.new

task default: %i[spec rubocop]
