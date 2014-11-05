require 'spec_helper'

# Main module
module Torganiser
  describe Matcher do

    let(:result) { Matcher.match(file) }

    context 'matching an informative filename' do

      let(:file) { 'Hello.S02E01.mp4' }

      it 'matches season number' do
        expect(result[:season]).to eq '02'
      end

      it 'matches episode number' do
        expect(result[:episode]).to eq '01'
      end

      it 'matches series name' do
        expect(result[:name]).to eq 'Hello'
      end

      context 'that does not contain year information' do

        it 'matches a nil year' do
          expect(result[:year]).to be_nil
        end

      end

      context 'that contains year information' do

        let(:file) { 'Hello.2008.S02E01.mp4' }

        it 'matches year' do
          expect(result[:year]).to eq '2008'
        end

      end

      context 'that is a double episode' do

        let(:file) { 'file/path/Hello.2008.S02E01E02.mp4' }

        it 'matches season number' do
          expect(result[:season]).to eq '02'
        end

        it 'matches first episode number' do
          expect(result[:episode]).to eq '01'
        end

      end

      context 'in short format' do
        let(:file) { 'Hello.2014.302.hdtv-lol.mp4' }

        it 'matches season number' do
          expect(result[:season]).to eq '3'
        end

        it 'matches episode number' do
          expect(result[:episode]).to eq '02'
        end

        context 'with an "x"' do
          let(:file) { 'Hello.2014.4x07.hdtv-lol.mp4' }

          it 'matches season number' do
            expect(result[:season]).to eq '4'
          end

          it 'matches episode number' do
            expect(result[:episode]).to eq '07'
          end

        end

        context 'surrounded in square brackets' do
          let(:file) { 'file/path/Wootle [3x08] Some title here.avi' }

          it 'matches season number' do
            expect(result[:season]).to eq '3'
          end

          it 'matches episode number' do
            expect(result[:episode]).to eq '08'
          end

        end

      end

      context 'that is dash-separated' do
        let(:file) { "Wiffle's Berry - S01E12-the title.avi" }

        it 'matches series name' do
          expect(result[:name]).to eq "Wiffle's Berry -"
        end

        it 'matches season number' do
          expect(result[:season]).to eq '01'
        end

        it 'matches episode number' do
          expect(result[:episode]).to eq '12'
        end
      end

      context 'that is a special' do

        context 'that is has no season' do
          let(:file) { 'Hello.2014.s00.hdtv-lol.mp4' }
          it 'matches season number as zero' do
            expect(result[:season]).to eq '0'
          end

          it 'matches episode number as nil' do
            expect(result[:episode]).to be_nil
          end
        end

        context 'with a season specified' do
          let(:file) { 'file/path/Hello.2014.s01.special.hdtv-lol.mp4' }

          it 'matches season number' do
            expect(result[:season]).to eq '01'
          end

          it 'matches episode number as nil' do
            expect(result[:episode]).to be_nil
          end

        end
      end

    end

  end
end
