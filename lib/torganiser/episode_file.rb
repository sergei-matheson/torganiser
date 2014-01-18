module Torganiser
  class EpisodeFile

    attr_reader :file

    @@episode_info_matcher = %r{^
      (?<series>.+)    # Series name, and possibly year
      .s(?<season>\d+) # season number
      e(?<episode>\d+) # episode number
      \..*$            # everything else
    }ix

    @@year_matcher = /^\d{4}$/

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
      @season ||= episode_info[:episode].to_i
    end

    def series_name
      @series_name ||= series[:name]
    end

    def series_year
      @series_year ||= series[:year]
    end

    private

    def series
      @series ||= extract_series
    end

    def extract_series
      parts = episode_info[:series].split('.')
      year = nil
      if match = @@year_matcher.match(parts.last)
        parts.pop
        year = match[0].to_i
      end
      {name:parts.join(' '), year:year}
    end

    def episode_info
      @episode_info ||= extract_episode_info
    end

    def extract_episode_info
      @@episode_info_matcher.match(basename)
    end

  end
end