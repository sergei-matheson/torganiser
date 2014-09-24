module Torganiser
  # Runs the organisation process for a given array of
  # files and extensions
  class Runner

    def initialize(collection, files:, extensions: [])
      @scanner = Scanner.new(files, extensions)
      @arranger = Arranger.new(collection)
    end

    def run
      @scanner.each do |episode_file|
        arrange episode_file
      end
    end

    private
    def arrange episode_file
      @arranger.arrange episode_file
    end

  end

end
