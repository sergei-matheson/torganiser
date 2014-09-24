module Torganiser
  # Handles arranging episode files into a collection
  class Arranger

    attr_reader :collection

    def initialize collection
      @collection = collection
    end

    def arrange episode_file
      #/* debug */
      puts episode_file.basename
      #/* debug */
    end

  end
end
