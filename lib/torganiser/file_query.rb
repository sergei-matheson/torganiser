module Torganiser
  class FileQuery

    attr_reader :directories, :extensions

    def initialize dirs = nil, extensions = nil
      @directories = []
      @extensions = []
      add_directory(dirs)
      add_extension(extensions)
    end

    def add_extension extensions
      @extensions.concat([*extensions])
    end

    def add_directory dirs
      @directories.concat([*dirs])
    end

    def pattern
      directory_pattern + "/**/" + extension_pattern
    end

    private

    def directory_pattern
      pattern_for directories
    end

    def extension_pattern
      "*" + (extensions.count > 0 ? pattern_for(extensions): '')
    end

    def pattern_for items
      items.count > 1 ?  "{#{items.join(',')}}" : items.first
    end

  end
end
