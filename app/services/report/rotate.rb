# frozen_string_literal: true

module Report
  class Rotate
    ROTATE = {
      'RIGHT' => {
        'NORTH' => 'EAST',
        'EAST' => 'SOUTH',
        'SOUTH' => 'WEST',
        'WEST' => 'NORTH'
      },
      'LEFT' => {
        'NORTH' => 'WEST',
        'WEST' => 'SOUTH',
        'SOUTH' => 'EAST',
        'EAST' => 'NORTH'
      }
    }

    def self.call(command, direction)
      ROTATE[command][direction]
    end
  end
end
