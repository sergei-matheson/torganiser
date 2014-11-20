require 'spec_helper'

# Main module
module Torganiser
  describe Runner do

    context 'when initialised with a scanner and arranger' do

      subject do
        Runner.new(
          scanner: scanner, arranger: arranger
        )
      end

      let(:arranger) do
        instance_double('Torganiser::Arranger', arrange: nil)
      end

      let(:scanner) do
        instance_double('Torganiser::Scanner', each: nil)
      end

      describe 'the scanner' do

        it 'is used to retrieve episode files' do
          expect(scanner).to receive(:each)
          subject.run
        end

      end

      context 'if any episode files are found' do

        let(:episode_file) { instance_double('Torganiser::EpisodeFile') }

        before do
          allow(scanner).to receive(:each).and_yield episode_file
        end

        describe 'the arranger' do

          it 'is used to arrange episode files found by the scanner' do
            expect(arranger).to receive(:arrange).with(episode_file)
            subject.run
          end

        end
      end

    end

  end
end
