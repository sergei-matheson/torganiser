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
        year = episode_info[:year]
        year = year.to_i if year
        Series.new(series_name, year: year)
      end
    end

    private

    def series_name
      episode_info[:name].split('.').join(' ').gsub(/[^a-z]+$/i, '')
    end

    def episode_info
      @episode_info ||= Matcher.match(basename) || fail(
        "Unable to parse #{file}"
      )
    end

    # A matcher that can extract semantic information from a
    # properly named file.
    module Matcher
      separator = '(\.|\s|\s?\-\s?)'

      long_format = [
        's(?<season>\d+)', # season number
        'e(?<episode>\d+)', # episode number
        '(e\d+)?' # optional second episode number, ignored
      ].join('\s?') # optionally space separated

      # season number and episode number together, optionally with an 'x'
      short_format = '\[?(?<season>\d+)x?(?<episode>\d{2})\]?'

      # specials don't fit nicely into the season/episode model.
      special = "s(?<season>0)(?<episode>0)|s(?<season>\\d+)#{separator}special"

      season_info = "(#{long_format}|#{short_format}|#{special})"

      # Series name, and possibly year
      series_with_year = '(?<name>.*)\.(?<year>\d{4})'
      series_without_year = '(?<name>.*)'

      # Series without year takes precedence
      series = "(#{series_with_year}|#{series_without_year})"

      PATTERN  = /^
        #{series}                  # Series name, and possibly year
        #{separator}#{season_info} # season info
        #{separator}.*$            # stuff we don't care about
      /ix

      def self.match(basename)
        PATTERN.match basename
      end
    end
  end
end
