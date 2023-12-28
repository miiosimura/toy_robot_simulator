# frozen_string_literal: true

module Report
  class Move
    def self.call(x_position, y_position, direction)
      case direction
      when 'SOUTH'
        y_position += 1 if y_position.between?(0, 3)
      when 'NORTH'
        y_position -= 1 if y_position.between?(1, 4)
      when 'EAST'
        x_position += 1 if x_position.between?(0, 3)
      when 'WEST'
        x_position -= 1 if x_position.between?(1, 4)
      end

      [x_position, y_position]
    end
  end
end
