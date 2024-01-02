# frozen_string_literal: true

require 'rails_helper'

describe Report::Rotate do
  describe '#call' do
    context 'when rotating RIGHT' do
      it 'rotates from NORTH to EAST' do
        expect(described_class.call('RIGHT', 'NORTH')).to eq('EAST')
      end

      it 'rotates from EAST to SOUTH' do
        expect(described_class.call('RIGHT', 'EAST')).to eq('SOUTH')
      end

      it 'rotates from SOUTH to WEST' do
        expect(described_class.call('RIGHT', 'SOUTH')).to eq('WEST')
      end

      it 'rotates from WEST to NORTH' do
        expect(described_class.call('RIGHT', 'WEST')).to eq('NORTH')
      end
    end

    context 'when rotating LEFT' do
      it 'rotates from NORTH to WEST' do
        expect(described_class.call('LEFT', 'NORTH')).to eq('WEST')
      end

      it 'rotates from WEST to SOUTH' do
        expect(described_class.call('LEFT', 'WEST')).to eq('SOUTH')
      end

      it 'rotates from SOUTH to EAST' do
        expect(described_class.call('LEFT', 'SOUTH')).to eq('EAST')
      end

      it 'rotates from NORTH to EAST' do
        expect(described_class.call('LEFT', 'EAST')).to eq('NORTH')
      end
    end
  end
end