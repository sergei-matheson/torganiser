module Torganiser
  # Handles scanning a set of directories and files
  # and returning any found episode files.
  class Scanner
    include Enumerable

    def initialize(files, extensions, ignored)
      file_query.add_extension extensions
      ignore ignored
      add_files files
    end

    def each
      all_files { |file| yield file unless ignored? file }
    end

    private

    def all_files
      ordinary_files.each do |file|
        yield file
      end
      directory_files.each do |file|
        yield file
      end
    end

    def ignored?(file)
      @ignored_patterns.any? { |pattern| pattern.match file }
    end

    def ignore(ignored)
      ignored_patterns.concat([*ignored])
    end

    def ignored_patterns
      @ignored_patterns ||= []
    end

    def directory_files
      if file_query.empty?
        []
      else
        Dir[file_query.pattern].select { |file| File.file?(file) }
      end
    end

    def add_files(files)
      files.each do |file|
        add_file file
      end
    end

    def add_file(file)
      if File.file?(file)
        ordinary_files << file
      else
        file_query.add_directory file
      end
    end

    def ordinary_files
      @ordinary_files ||= []
    end

    def file_query
      @file_query ||= FileQuery.new
    end
  end
end
