require 'spec_helper'

module Torganiser

  describe Scanner do

    context "when initialised with an array of files" do

      let(:files) { ["/tmp/file1", "/tmp/dir1", "/tmp/file2", "/tmp/dir2"] }

      let(:extensions) { double("extensions") }

      subject { Scanner.new(files, extensions) }

      let(:query_pattern) { double("query pattern") }

      let(:file_query) do
        instance_double(
          "Torganiser::FileQuery",
          pattern: query_pattern,
          add_directory: nil,
          add_extension: nil,
          empty?: false
        )
      end

      let(:query_results) { ["/tmp/dir1/file3", "/tmp/dir2/file4"] }

      before do
        allow(File).to receive(:file?) { |path| path.match(/file/) }
        allow(FileQuery).to receive(:new).and_return file_query
        allow(Dir).to receive(:[]).and_return query_results
      end

      describe "a file query" do
        it "is created for any non-ordinary files" do
          expect(file_query).to receive(:add_directory).with("/tmp/dir1")
          expect(file_query).to receive(:add_directory).with("/tmp/dir2")
          subject
        end

        it "is given any extensions" do
          expect(file_query).to receive(:add_extension).with extensions
          subject
        end

        context "when enumerating" do
          it "is used do a directory search" do
            expect(Dir).to receive(:[]).with query_pattern
            subject.each { |_| }
          end
        end
      end

      it "enumerates the ordinary files, and files found in the directories" do
        expect { |b| subject.each(&b) }.to yield_successive_args(
          "/tmp/file1",
          "/tmp/file2",
          "/tmp/dir1/file3",
          "/tmp/dir2/file4"
        )
      end


    end
  end
end
