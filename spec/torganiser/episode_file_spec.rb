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

      end
    end

    context "when initialised with a file whose name cannot be parsed" do

      let(:file) { "file/path/Hello.this-contains-no-information.mp4"}

      it 'blows up in a more helpful manner' do
        expect{ subject.series }.to raise_error(/Unable to parse #{file}/) end

    end

  end

end
