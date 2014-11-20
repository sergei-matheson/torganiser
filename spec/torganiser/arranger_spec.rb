require 'spec_helper'

# Main module
module Torganiser
  describe Arranger do

    describe 'for a collection' do
      subject { Arranger.new('/my/media') }

      context 'when arranging a file' do

        before do
          allow(FileUtils).to receive(:mkdir_p)
          allow(FileUtils).to receive(:mv)
        end

        let(:file) { '/tmp/stuff/Waffle.Cone.2007.S01E02.HDTV.x264-LOL.mp4' }

        it 'creates a destination by series and season' do
          expect(FileUtils).to receive(:mkdir_p).with(
            '/my/media/Waffle Cone (2007)/Season 1'
          )
          subject.arrange file
        end

        it 'moves the file to the destination' do
          expect(FileUtils).to receive(:mv).with(
            file,
            '/my/media/Waffle Cone (2007)/Season 1'
          )
          subject.arrange file
        end

        context 'when set up to copy, rather than move' do

          before do
            allow(FileUtils).to receive(:cp)
          end

          subject { Arranger.new('/my/media', copy: true) }

          it 'copies the file to the destination' do
            expect(FileUtils).to receive(:cp).with(
              file,
              '/my/media/Waffle Cone (2007)/Season 1'
            )
            subject.arrange file
          end
        end

      end
    end
  end
end
