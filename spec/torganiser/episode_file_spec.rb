require 'spec_helper'

module Torganiser

  describe EpisodeFile do

    context "when initialized with an informative filename" do

      let(:file) { "file/path/Hello.S02E01.mp4"}

      subject { EpisodeFile.new(file) }

      it 'extracts the base file name' do
        expect(subject.basename).to eq 'Hello.S02E01.mp4'
      end

      it 'extracts season number' do
        expect(subject.season).to eq 2
      end

      it 'extracts episode number' do
        expect(subject.episode).to eq 1
      end

      it 'extracts series name' do
        expect(subject.series_name).to eq "Hello"
      end

      context "that contains year information" do

        let(:file) { "file/path/Hello.2008.S02E01.mp4"}

        it 'extracts series year' do
          expect(subject.series_year).to eq 2008
        end

      end

      context "that has a series name in dot-format" do

        let(:file) { "file/path/Goodbye.Hello.Hamburger.2008.S02E01.mp4"}

        it 'extracts the name with spaces' do
          expect(subject.series_name).to eq "Goodbye Hello Hamburger"
        end

      end

    end

  end

end
