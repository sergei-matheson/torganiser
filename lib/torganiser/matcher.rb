module Torganiser
  # A matcher that can extract semantic information from a
  # properly named file.
  class Matcher
    class << self
      def match(basename)
        pattern.match basename
      end

      private

      def pattern
        @pattern ||= /^
          #{series}                  # Series name, and possibly year
          #{separator}#{season_info} # season info
          #{separator}.*$            # stuff we don't care about
        /ix
      end

      def separator
        @separator ||= one_of '\.', '\s', '\s?\-\s?'
      end

      def series
        # Series with year takes precedence
        one_of series_with_year, series_without_year
      end

      def series_without_year
        '(?<name>.*)'
      end

      def series_with_year
        '(?<name>.*)\.(?<year>\d{4})'
      end

      def season_info
        one_of long_format, short_format, special
      end

      def long_format
        [
          's(?<season>\d+)',  # season number
          'e(?<episode>\d+)', # episode number
          '(e\d+)?'           # optional second episode number, ignored
        ].join('\s?')         # optionally space separated
      end

      def short_format
        '\[?(?<season>\d+)x?(?<episode>\d{2})\]?'
      end

      def special
        # specials don't fit nicely into the season/episode model.
        "s(?<season>0)0|s(?<season>\\d+)#{separator}special"
      end

      def one_of(*args)
        MatchOne.new(args)
      end
    end
  end
end
