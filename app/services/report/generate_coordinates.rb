# frozen_string_literal: true

module Report
  class GenerateCoordinates
    def self.call(command)
      coordinates = command.split[1]&.split(',')
      x_position, y_position, direction = coordinates
      error = validate_place(command).failure if validate_place(command).failure?

      [x_position.to_i, y_position.to_i, direction, error]
    end

    private

    def self.validate_place(command)
      ValidatePlaceCommand.new(command).call
    end
  end
end
