require 'fileutils'

module Torganiser
  # Handles arranging episode files into a collection
  class Arranger

    attr_reader :collection, :dry_run

    def initialize collection, dry_run: false
      @collection = collection
      @dry_run = dry_run
    end

    def arrange file
      episode = EpisodeFile.new(file)
      move(episode, Destination.new(collection, episode))
    end

    private

    def move episode, destination
      directory = destination.directory

      file_utils.mkdir_p directory unless File.exists? directory
      file_utils.mv episode.file, directory
    end

    def file_utils
      @file_utils ||= dry_run ? FileUtils::DryRun : FileUtils
    end

    # Models a destination for an episode file in a collection
    class Destination

      attr_reader :collection, :episode_file

      def initialize collection, episode_file
        @collection = collection
        @episode_file = episode_file
      end

      def directory
        @directory ||= File.join(collection, series_dir, season_dir)
      end

      private
      def season_dir
        "Season #{episode_file.season}"
      end

      def series_dir
        series.display_name
      end

      def series
        episode_file.series
      end

    end
  end
end
