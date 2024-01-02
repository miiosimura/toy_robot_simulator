# frozen_string_literal: true

require 'rails_helper'

describe Report::Move do
  describe '#call' do
    context 'when direction is SOUTH' do
      it 'increments y_position if y_position is between 0 and 3' do
        result = described_class.call(2, 2, 'SOUTH')
        expect(result).to eq([2, 3])
      end

      it 'does not increment y_position if y_position is not between 0 and 3' do
        result = described_class.call(2, 4, 'SOUTH')
        expect(result).to eq([2, 4])
      end
    end

    context 'when direction is NORTH' do
      it 'decrements y_position if y_position is between 1 and 4' do
        result = described_class.call(2, 3, 'NORTH')
        expect(result).to eq([2, 2])
      end

      it 'does not decrement y_position if y_position is not between 1 and 4' do
        result = described_class.call(2, 0, 'NORTH')
        expect(result).to eq([2, 0])
      end
    end

    context 'when direction is EAST' do
      it 'increments x_position if x_position is between 0 and 3' do
        result = described_class.call(2, 2, 'EAST')
        expect(result).to eq([3, 2])
      end

      it 'does not increment x_position if x_position is not between 0 and 3' do
        result = described_class.call(4, 2, 'EAST')
        expect(result).to eq([4, 2])
      end
    end

    context 'when direction is WEST' do
      it 'decrements x_position if x_position is between 1 and 4' do
        result = described_class.call(3, 2, 'WEST')
        expect(result).to eq([2, 2])
      end

      it 'does not decrement x_position if x_position is not between 1 and 4' do
        result = described_class.call(0, 2, 'WEST')
        expect(result).to eq([0, 2])
      end
    end
  end
end