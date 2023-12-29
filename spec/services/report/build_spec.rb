# frozen_string_literal: true

require 'rails_helper'

describe Report::Build do
  describe '#call' do
    context 'success' do
      context 'simple example A' do
        let(:input) do
          "PLACE 0,0,SOUTH\n" \
          "MOVE\n" \
          'REPORT'
        end

        it { expect(Report::Build.call(input)).to eq('0,1,SOUTH') }
      end

      context 'simple example B' do
        let(:input) do
          "PLACE 0,0,SOUTH\n" \
          "LEFT\n" \
          'REPORT'
        end

        it { expect(Report::Build.call(input)).to eq('0,0,EAST') }
      end

      context 'simple example C' do
        let(:input) do
          "PLACE 1,2,EAST\n" \
          "MOVE\n"\
          "MOVE\n"\
          "RIGHT\n"\
          "MOVE\n"\
          'REPORT'
        end

        it { expect(Report::Build.call(input)).to eq('3,3,SOUTH') }
      end
    end

    context 'custom tests' do
      context 'when it receives a command that would make the robot fall' do
        let(:input) do
          "PLACE 4,3,SOUTH\n" \
          "MOVE\n"\
          "MOVE\n"\
          'REPORT'
        end

        it 'skips the command to avoid falling' do
          expect(Report::Build.call(input)).to eq('4,4,SOUTH')
        end
      end

      context 'when it receives other commands after it avoids falling' do
        let(:input) do
          "PLACE 4,3,SOUTH\n" \
          "MOVE\n"\
          "MOVE\n"\
          "MOVE\n"\
          "LEFT\n"\
          "LEFT\n"\
          "MOVE\n"\
          "RIGHT\n"\
          "MOVE\n"\
          "LEFT\n"\
          'REPORT'
        end

        it 'ignores only the commands that would make the robot fall' do
          expect(Report::Build.call(input)).to eq('4,3,NORTH')
        end
      end

      context 'when it receives non upper-case commands' do
        let(:input) do
          "place 2,2,South\n" \
          "move\n"\
          "MOVE\n"\
          "LefT\n"\
          "mOvE\n"\
          'rEPORT'
        end

        it 'accepts the commands as well' do
          expect(Report::Build.call(input)).to eq('3,4,EAST')
        end
      end

      context 'when it receives an unknow command' do
        let(:input) do
          "PLACE 0,0,SOUTH\n" \
          "LEFT\n" \
          "JUMP\n" \
          "MOVE\n" \
          'REPORT'
        end

        it 'only ignores the invalid command' do
          expect(Report::Build.call(input)).to eq('1,0,EAST')
        end
      end

      context 'when the first command is not PLACE' do
        context 'with the first command as MOVE' do
          let(:input) do
            "MOVE\n"\
            "PLACE 4,3,NORTH\n" \
            "MOVE\n"\
            'REPORT'
          end

          it 'ignores the command until the PLACE command is given' do
            expect(Report::Build.call(input)).to eq('4,2,NORTH')
          end
        end

        context 'with the first command as RIGHT' do
          let(:input) do
            "RIGHT\n"\
            "PLACE 4,3,NORTH\n" \
            "MOVE\n"\
            'REPORT'
          end

          it 'ignores the command until the PLACE command is given' do
            expect(Report::Build.call(input)).to eq('4,2,NORTH')
          end
        end

        context 'with the first command as LEFT' do
          let(:input) do
            "LEFT\n"\
            "PLACE 4,3,NORTH\n" \
            "MOVE\n"\
            'REPORT'
          end

          it 'ignores the command until the PLACE command is given' do
            expect(Report::Build.call(input)).to eq('4,2,NORTH')
          end
        end
      end

      context 'when it receives an invalid coordinate on the PLACE command' do
        context 'with invalid coordinate X' do
          let(:input) do
            "PLACE 7,3,WEST\n" \
            "MOVE\n"\
            "RIGHT\n"\
            'REPORT'
          end

          it 'returns an error informing the valid coordinates range' do
            expect(Report::Build.call(input))
              .to eq("Invalid command: 'PLACE 7,3,WEST'. Coordinates must be between 0 and 4")
          end
        end

        context 'with invalid coordinate Y' do
          let(:input) do
            "PLACE 2,-4,WEST\n" \
            "MOVE\n"\
            "RIGHT\n"\
            'REPORT'
          end

          it 'returns an error informing the valid coordinates range' do
            expect(Report::Build.call(input))
              .to eq("Invalid command: 'PLACE 2,-4,WEST'. Coordinates must be between 0 and 4")
          end
        end

        context 'with an invalid direction' do
          let(:input) do
            "PLACE 2,3,NORTHWEST\n" \
            "MOVE\n"\
            "RIGHT\n"\
            'REPORT'
          end

          it 'returns an error informing the valid directions options' do
            expect(Report::Build.call(input))
              .to eq("Invalid command: 'PLACE 2,3,NORTHWEST'. Direction must be: NORTH, EAST, SOUTH or WEST")
          end
        end

        context 'with an invalid direction and coordinates' do
          let(:input) do
            "PLACE 21,12,NORTHWEST\n" \
            "MOVE\n"\
            "RIGHT\n"\
            'REPORT'
          end

          it 'returns an error informing the valid coordinates and directions' do
            expect(Report::Build.call(input))
              .to eq("Invalid command: 'PLACE 21,12,NORTHWEST'. Direction must be: NORTH, EAST, SOUTH or WEST")
          end
        end

        context 'with a second valid PLACE command' do
          let(:input) do
            "PLACE 7,3,WEST\n" \
            "MOVE\n"\
            "RIGHT\n"\
            "PLACE 3,3,WEST\n" \
            "MOVE\n"\
            "RIGHT\n"\
            'REPORT'
          end

          it 'ignores everything until a valid command PLACE is given' do
            expect(Report::Build.call(input)).to eq('2,3,NORTH')
          end
        end

        context 'when place command missing a comma' do
          let(:input) do
            "PLACE 1,2, EAST\n" \
            "PLACE 4,3 SOUTH\n" \
            'REPORT'
          end

          it 'ignores everything until a valid command PLACE is given' do
            expect(Report::Build.call(input)).to eq("Invalid command: 'PLACE 4,3 SOUTH'. The command is invalid. "\
                                                    "Check your writing and try again")
          end
        end
      end
    end
  end
end
