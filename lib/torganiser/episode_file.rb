module Torganiser
  # Models a file that contains a single episode of a TV series.
  # Attempts to extract episode data, based on the filename.
  class EpisodeFile

    attr_reader :file

    def initialize(file)
      @file = file
    end

    def basename
      @basename ||= File.basename(@file)
    end

    def season
      @season ||= episode_info[:season].to_i
    end

    def episode
      @episode ||= episode_info[:episode].to_i
    end

    def series
      @series ||= begin
        parts = episode_info[:name].split('.')
        year = year.to_i if year = episode_info[:year]
        Series.new(parts.join(' '), year: year)
      end
    end

    private

    def episode_info
      @episode_info ||= Matcher.match(basename) or raise(
        "Unable to parse #{file}"
      )
    end

    # A matcher that can extract semantic information from a
    # properly named file.
    module Matcher
      separator = '(\.|\s)'

      long_format = [
        's(?<season>\d+)', # season number
        'e(?<episode>\d+)' # episode number
      ].join

      # season number and episode number together
      short_format = '(?<season>\d+)(?<episode>\d{2})'

      season_info = "(#{long_format}|#{short_format})"

      # Series name, and possibly year
      series_with_year = '(?<name>.*)\.(?<year>\d{4})'
      series_without_year = '(?<name>.*)'

      # Series without year takes precedence
      series = "(#{series_with_year}|#{series_without_year})"

      PATTERN  = %r{^
        #{series}                  # Series name, and possibly year
        #{separator}#{season_info} # season info
        #{separator}.*$            # everything else
      }ix

      def self.match basename
        PATTERN.match basename
      end

    end

  end
end
