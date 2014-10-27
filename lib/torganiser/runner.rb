module Torganiser
  # Runs the organisation process for a given array of
  # files, extensions, and ignored files
  class Runner

    def initialize(
      collection, files: [], extensions: [], ignored: [], dry_run: false
    )
      @scanner = Scanner.new(
        files, extensions,
        ignored.map { |string| Regexp.new(string) }
      )
      @arranger = Arranger.new(collection, dry_run: dry_run)
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
