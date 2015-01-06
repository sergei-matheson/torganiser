require 'spec_helper'

# Main module
module Torganiser
  describe EpisodeFile do
    subject { EpisodeFile.new(file) }

    let(:match) do
      {
        name: 'Hello',
        season: '02',
        episode: '01'
      }
    end

    let(:file) { 'file/path/Hello.S02E01.mp4' }

    before do
      allow(Matcher).to receive(:match).and_return match
    end

    context 'when initialized with a filename' do
      it 'extracts the base file name' do
        expect(subject.basename).to eq 'Hello.S02E01.mp4'
      end

      it 'matches the basename using the Matcher' do
        expect(Matcher).to receive(:match).with('Hello.S02E01.mp4')
        subject.series
      end

      it 'extracts season number as an integer' do
        expect(subject.season).to eq 2
      end

      it 'extracts episode number as an integer' do
        expect(subject.episode).to eq 1
      end

      context 'that contains year information' do
        let(:match) do
          {
            name: 'Hello',
            year: '2008'
          }
        end

        it 'creates a series with a name and year' do
          expect(Series).to receive(:new).with(
            'Hello', year: 2008
          )
          subject.series
        end
      end

      context 'that has a series name in dot-format' do
        let(:match) do
          {
            name: 'Goodbye.Hello.Hamburger'
          }
        end

        it 'creates a series with a name with spaces' do
          expect(Series).to receive(:new).with(
            'Goodbye Hello Hamburger',
            anything
          )
          subject.series
        end
      end

      context 'that is dash-separated' do
        let(:match) do
          {
            name: "Wiffle's Berry - "
          }
        end

        it 'creates a series with the correct name' do
          expect(Series).to receive(:new).with(
            "Wiffle's Berry", year: nil
          )
          subject.series
        end
      end
    end

    context 'when initialised with a file whose name cannot be parsed' do
      let(:match) { nil }

      it 'blows up in a more helpful manner' do
        expect { subject.series }.to raise_error(/Unable to parse #{file}/)
      end
    end
  end
end
