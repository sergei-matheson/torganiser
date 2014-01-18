require "bundler/gem_tasks"
require "rspec/core/rake_task"


begin
  require 'cane/rake_task'

  desc "Run cane to check quality metrics"
  Cane::RakeTask.new(:quality) do |cane|
    cane.abc_max = 10
    cane.add_threshold 'coverage/.last_run.json', :>=, 99
  end

rescue LoadError
  warn "cane not available, quality task not provided."
end

RSpec::Core::RakeTask.new(:spec)

task :default => [ :spec, :quality ]
