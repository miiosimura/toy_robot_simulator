# frozen_string_literal: true

module Report
  class GenerateCoordinates
    DIRECTIONS = %w[NORTH EAST SOUTH WEST].freeze

    def self.call(command)
      coordinates = command.split[1]&.split(',')
      x_position, y_position, direction = coordinates
      x_position = x_position.to_i
      y_position = y_position.to_i
      error = if !DIRECTIONS.include?(direction&.upcase)
                "Invalid command: '#{command}', directions must be: NORTH, EAST, SOUTH or WEST"
              elsif !x_position.between?(0, 4) || !y_position.between?(0, 4)
                "Invalid command: '#{command}', coordinates must be between 0 and 4"
              end

      [x_position, y_position, direction, error]
    end
  end
end
