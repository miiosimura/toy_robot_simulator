# frozen_string_literal: true

require 'dry/monads'

module Report
  class ValidatePlaceCommand
    include Dry::Monads[:result]

    DIRECTIONS = %w[NORTH EAST SOUTH WEST].freeze

    def initialize(command)
      @command = command
      @x_position, @y_position, @direction = command.split[1]&.split(',')
    end

    def call
      return failure(command, invalid_command) if direction.nil?
      return failure(command, unknown_direction) if !DIRECTIONS.include?(direction&.upcase)
      return failure(command, invalid_coordinates) if !x_position.to_i.between?(0, 4) || !y_position.to_i.between?(0, 4)

      Success()
    end

    attr_accessor :command, :x_position, :y_position, :direction

    def failure(command, message)
      Failure("Invalid command: '#{command}'. #{message}")
    end

    def invalid_command
      "The command is invalid. Check your writing and try again"
    end

    def unknown_direction
      "Direction must be: NORTH, EAST, SOUTH or WEST"
    end

    def invalid_coordinates
      "Coordinates must be between 0 and 4"
    end
  end
end
