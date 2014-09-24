module Torganiser
  # Runs the organisation process for a given array of
  # directories and extensions
  class Runner

    attr_reader :directories, :extensions

    def initialize(directories)
      FileQuery.new(directories: directories)
    end

    def run
    end

  end
end
