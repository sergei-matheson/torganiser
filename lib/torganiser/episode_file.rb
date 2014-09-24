module Torganiser
  # Models a file that contains a single episode of a TV series.
  # Attempts to extract episode data, based on the filename.
  class EpisodeFile

    attr_reader :file

    EPISODE_INFO_MATCHER = %r{^
      (?<series>.+)    # Series name, and possibly year
      .s(?<season>\d+) # season number
      e(?<episode>\d+) # episode number
      \..*$            # everything else
    }ix

    YEAR_MATCHER = /^\d{4}$/

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
        parts = episode_info[:series].split('.')
        year = YEAR_MATCHER.match(parts.last) ? parts.pop.to_i : nil
        Series.new(parts.join(' '), year:year)
      end
    end

    private

    def episode_info
      @episode_info ||= EPISODE_INFO_MATCHER.match(basename)
    end

  end
end
