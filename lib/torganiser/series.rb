module Torganiser

  # Models the series information from an episode file
  class Series

    attr_reader :name, :year

    def initialize name, year: nil
      @name = name
      @year = year
    end

    def display_name
      @display_name = year ? "#{name} (#{year})" : name
    end

  end

end
