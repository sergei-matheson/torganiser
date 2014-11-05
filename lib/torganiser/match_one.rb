module Torganiser
  # Creates a regex-ready string for matching one of a set of alternatives
  class MatchOne
    def initialize(alternatives)
      @alternatives = alternatives
    end

    def to_s
      "(#{@alternatives.join('|')})"
    end
  end
end
