module Torganiser
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
    special = "s(?<season>0)0|s(?<season>\\d+)#{separator}special"

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
