require 'fileutils'

module Torganiser
  # Handles arranging episode files into a collection
  class Arranger
    attr_reader :collection, :dry_run, :copy

    def initialize(collection, dry_run: false, copy: false)
      @collection = collection
      @dry_run = dry_run
      @copy = copy
    end

    def arrange(file)
      episode = EpisodeFile.new(file)
      arrange_episode(episode)
    end

    private

    def arrange_episode(episode)
      arrange_method.call episode.file, ensure_directory_for(episode)
    end

    def ensure_directory_for(episode)
      Destination.new(collection, episode).directory.tap do |dir|
        file_utils.mkdir_p dir unless File.exist? dir
      end
    end

    def arrange_method
      @arrange_method ||= file_utils.method(@copy ? :cp : :mv)
    end

    def file_utils
      @file_utils ||= dry_run ? FileUtils::DryRun : FileUtils
    end

    # Models a destination for an episode file in a collection
    class Destination
      attr_reader :collection, :episode_file

      def initialize(collection, episode_file)
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
