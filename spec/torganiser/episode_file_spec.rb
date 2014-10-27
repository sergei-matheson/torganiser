require 'spec_helper'

module Torganiser

  describe EpisodeFile do

    subject { EpisodeFile.new(file) }

    context "when initialized with an informative filename" do

      let(:file) { "file/path/Hello.S02E01.mp4"}

      it 'extracts the base file name' do
        expect(subject.basename).to eq 'Hello.S02E01.mp4'
      end

      it 'extracts season number' do
        expect(subject.season).to eq 2
      end

      it 'extracts episode number' do
        expect(subject.episode).to eq 1
      end

      it 'creates a series with a name and no year' do
        expect(Series).to receive(:new).with(
          "Hello", year: nil
        )
        subject.series
      end

      context "that contains year information" do

        let(:file) { "file/path/Hello.2008.S02E01.mp4"}

        it 'creates a series with a name and year' do
          expect(Series).to receive(:new).with(
            "Hello", year: 2008
          )
          subject.series
        end

      end

      context "that has a series name in dot-format" do

        let(:file) { "file/path/Goodbye.Hello.Hamburger.2008.S02E01.mp4"}

        it 'creates a series with a name with spaces' do
          expect(Series).to receive(:new).with(
            "Goodbye Hello Hamburger",
            anything
          )
          subject.series
        end

      end

      context "in short format" do
        let(:file) { "file/path/Hello.2014.302.hdtv-lol.mp4" }

        it 'extracts season number' do
          expect(subject.season).to eq 3
        end

        it 'extracts episode number' do
          expect(subject.episode).to eq 2
        end

        context "with an 'x'" do
          let(:file) { "file/path/Hello.2014.4x07.hdtv-lol.mp4" }

          it 'extracts season number' do
            expect(subject.season).to eq 4
          end

          it 'extracts episode number' do
            expect(subject.episode).to eq 7
          end

        end

        context "surrounded in square brackets" do
          let(:file) { "file/path/Wootle [3x08] Some title here.avi" }

          it 'extracts season number' do
            expect(subject.season).to eq 3
          end

          it 'extracts episode number' do
            expect(subject.episode).to eq 8
          end

        end

      end

      context "that is dash-separated" do
        let(:file) { "Wiffle's Berry - S01E12-the title.avi" }

        it 'extracts series correctly' do
          expect(Series).to receive(:new).with(
            "Wiffle's Berry", year: nil
          )
          subject.series
        end

        it 'extracts season number' do
          expect(subject.season).to eq 1
        end

        it 'extracts episode number' do
          expect(subject.episode).to eq 12
        end
      end

      context "that is a special" do
        let(:file) { "file/path/Hello.2014.s00.hdtv-lol.mp4" }

        it 'extracts season number as zero' do
          expect(subject.season).to eq 0
        end

        it 'extracts episode number as zero' do
          expect(subject.episode).to eq 0
        end

      end

    end

    context "when initialised with a file whose name cannot be parsed" do

      let(:file) { "file/path/Hello.this-contains-no-information.mp4"}

      it 'blows up in a more helpful manner' do
        expect{ subject.series }.to raise_error(/Unable to parse #{file}/) end

    end

  end

end
