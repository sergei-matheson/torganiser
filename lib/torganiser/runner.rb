module Torganiser
  # Runs the organisation process for a given array of
  # files, extensions, and ignored files
  class Runner
    def initialize(scanner: scanner, arranger: arranger)
      @scanner = scanner
      @arranger = arranger
    end

    def run
      @scanner.each do |episode_file|
        arrange episode_file
      end
    end

    private

    def arrange(episode_file)
      @arranger.arrange episode_file
    end
  end
end
