require 'spec_helper'

# Main module
module Torganiser
  describe Series do
    context 'when initialized with a name' do
      subject { Series.new('Pear Tree') }

      it 'has a display name' do
        expect(subject.display_name).to eq 'Pear Tree'
      end

      context 'and year' do
        subject { Series.new('Pear Tree', year: 2009) }

        it 'has a display name that includes year' do
          expect(subject.display_name).to eq 'Pear Tree (2009)'
        end
      end
    end
  end
end
