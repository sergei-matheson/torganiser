require 'spec_helper'

# Main module
module Torganiser
  describe FileQuery do
    context 'when initialised' do
      context 'with no arguments' do
        it 'has no directories' do
          expect(subject.directories).to be_empty
        end

        it 'has no media extensions' do
          expect(subject.extensions).to be_empty
        end

        it 'is empty' do
          expect(subject).to be_empty
        end
      end

      context 'with a directory' do
        subject { FileQuery.new(directories: 'woot/waffle') }

        it 'is not empty' do
          expect(subject).not_to be_empty
        end

        it 'adds that directory to the list of search directories' do
          expect(subject.directories).to eq ['woot/waffle']
        end
      end

      context 'with a directory and a media extension' do
        subject { FileQuery.new(directories: 'mydir', extensions: 'mp4') }

        it 'adds that directory to the list of search directories' do
          expect(subject.directories).to eq ['mydir']
        end

        it 'adds that extension to the list of media extensions' do
          expect(subject.extensions).to eq ['mp4']
        end
      end
    end

    describe 'search pattern' do
      let(:extensions) { nil }

      let(:directories) { 'the-dir' }

      subject do
        FileQuery.new(
          directories: directories,
          extensions: extensions
        )
      end

      context 'with one directory' do
        let(:directories) { 'stuff' }

        it 'includes only that directory' do
          expect(subject.pattern).to match(/^stuff\/\*\*/)
        end
      end

      context 'with multiple directories' do
        let(:directories) { %w(one two) }

        it 'includes all specified directories' do
          expect(subject.pattern).to match(/{one,two}\/\*\*/)
        end
      end

      context 'with no extensions' do
        it 'matches all files' do
          expect(subject.pattern).to match(/\*\*\/\*/)
        end
      end

      context 'with one extension' do
        let(:extensions) { 'mp4' }

        it 'includes only that extension' do
          expect(subject.pattern).to match(/\*\*\/\*mp4/)
        end
      end

      context 'with multiple extensions' do
        let(:extensions) { %w(mp4 mov qt) }

        it 'includes all specified extensions' do
          expect(subject.pattern).to match(/\*\*\/\*{mp4,mov,qt}/)
        end
      end
    end
  end
end
