# frozen_string_literal: true

require 'rails_helper'

describe Report::ValidatePlaceCommand do
  describe '#call' do
    context 'success' do
      it 'returns a success result' do
        command = 'PLACE 1,2,NORTH'
        result = described_class.new(command).call

        expect(result).to be_success
      end
    end

    context 'failure' do
      context 'with invalid direction' do
        it 'returns a failure result' do
          command = 'PLACE 1,2,INVALID_DIRECTION'
          result = described_class.new(command).call

          expect(result).to be_failure
          expect(result.failure).to eq("Invalid command: '#{command}'. Direction must be: NORTH, EAST, SOUTH or WEST")
        end
      end

      context 'with invalid coordinates' do
        it 'returns a failure result' do
          command = 'PLACE 5,6,NORTH'
          result = described_class.new(command).call

          expect(result).to be_failure
          expect(result.failure).to eq("Invalid command: '#{command}'. Coordinates must be between 0 and 4")
        end
      end

      context 'with invalid command' do
        it 'returns a failure result' do
          command = 'INVALID_COMMAND'
          result = described_class.new(command).call

          expect(result).to be_failure
          expect(result.failure).to eq("Invalid command: '#{command}'. The command is invalid. Check your writing and try again")
        end
      end
    end
  end
end