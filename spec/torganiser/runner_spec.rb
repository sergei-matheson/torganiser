require 'spec_helper'

module Torganiser

  describe Runner do

    context "when initialised with a collection, files and extensions" do

      let(:collection) { double("collection") }
      let(:files) { double("files") }
      let(:extensions) { double("extensions") }

      subject { Runner.new(collection, files: files, extensions: extensions) }

      let(:episode_files) { [] }
      let(:scanner) do
        instance_double("Torganiser::Scanner", episode_files: episode_files)
      end

      before do
        allow(Scanner).to receive(:new).and_return scanner
      end

      describe "a scanner" do

        it "is created for the files and extensions" do
          expect(Scanner).to receive(:new).with(files, extensions)
          subject.run
        end

        it "is used to retrieve episode files" do
          expect(scanner).to receive(:episode_files)
          subject.run
        end

      end

      context "if any episode files are found" do

        let(:episode_file) { instance_double("Torganiser::EpisodeFile") }

        let(:episode_files) { [episode_file] }

        describe "an arranger" do

          let(:arranger) do
            instance_double("Torganiser::Arranger", arrange: nil)
          end

          before do
            allow(Arranger).to receive(:new).and_return arranger
          end

          it "is created for the collection" do
            expect(Arranger).to receive(:new).with(collection)
            subject.run
          end

          it "is used to arrange episode files found by the scanner" do
            expect(arranger).to receive(:arrange).with(episode_file)
            subject.run
          end

        end
      end

    end

  end
end
