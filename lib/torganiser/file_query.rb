module Torganiser
  # A file query is specified by adding allowed directories,
  # and optionally, extensions.
  # The 'pattern' method returns a Dir.glob style pattern
  # that can be used to match a set of files.
  class FileQuery
    attr_reader :directories, :extensions

    def initialize(directories: nil, extensions: nil)
      @directories = []
      @extensions = []
      add_directory(directories) if directories
      add_extension(extensions) if extensions
    end

    def empty?
      @directories.empty?
    end

    def add_extension(extensions)
      @extensions.concat([*extensions])
    end

    def add_directory(directories)
      @directories.concat([*directories])
    end

    def pattern
      directory_pattern + '/**/' + extension_pattern
    end

    private

    def directory_pattern
      ItemsPattern.new(directories).to_s
    end

    def extension_pattern
      '*' + (extensions.count > 0 ? ItemsPattern.new(extensions).to_s : '')
    end

    # Models a pattern that matchers a series of one or more string items.
    class ItemsPattern
      attr_reader :items

      def initialize(items)
        @items = items
      end

      def to_s
        items.count > 1 ?  "{#{items.join(',')}}" : items.first
      end
    end
  end
end
