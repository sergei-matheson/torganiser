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
  end
end
