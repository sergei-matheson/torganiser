require 'spec_helper'

module Torganiser

  describe Series do

    context "when initialized with a name" do

      subject { Series.new(name: "Pear Tree") }

      it 'has a display name' do
        expect(subject.display_name).to eq 'Pear Tree'
      end

      context "and year" do

        subject { Series.new(name: "Pear Tree", year: 2009) }

        it 'has a display name that includes year' do
          expect(subject.display_name).to eq 'Pear Tree (2009)'
        end

      end

    end

  end

end
