require 'spec_helper'

# Main module
module Torganiser
  describe MatchOne do
    it 'stringifies a set of alternatives' do
      expect(MatchOne.new(%w(a b c)).to_s).to eq '(a|b|c)'
    end
  end
end
