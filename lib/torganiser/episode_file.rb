module Torganiser
  class EpisodeFile

    attr_reader :file

    @@episode_info_matcher = /^(?<series_info>.+)\.s(?<season>\d+)e(?<episode>\d+)\..*$/i

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
      @series_name ||= series_info[:name]
    end

    def series_year
      @series_year ||= series_info[:year]
    end

    private

    def series_info
      @series_info ||= extract_series_info
    end

    def extract_series_info
      parts = episode_info[:series_info].split('.')
      year = nil
      if match = year_matcher.match(parts.last)
        parts.pop
        year = match[0].to_i
      end
      {name:parts.join(' '), year:year}
    end

    def episode_info
      @episode_info ||= extract_episode_info
    end

    def extract_episode_info
      episode_info_matcher.match(basename)
    end

    def episode_info_matcher
      @@episode_info_matcher
    end

    def year_matcher
      @@year_matcher
    end

  end
end
