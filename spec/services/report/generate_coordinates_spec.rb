# frozen_string_literal: true

require 'rails_helper'

describe Report::GenerateCoordinates do
  describe '#call' do
    context 'with a valid command' do
      let(:command) { 'PLACE 1,2,NORTH' }

      it 'generates coordinates and handles validation' do
        result = described_class.call(command)

        expect(result[0]).to eq(1)
        expect(result[1]).to eq(2)
        expect(result[2]).to eq('NORTH')
        expect(result[3]).to be_nil
      end
    end

    context 'with an invalid command' do
      let(:command) { 'INVALID_COMMAND' }

      it 'handles validation error' do
        result = described_class.call(command)

        expect(result[0]).to eq(0)
        expect(result[1]).to eq(0)
        expect(result[2]).to be_nil
        expect(result[3]).not_to be_nil
      end
    end
  end
end