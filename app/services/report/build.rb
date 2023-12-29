# frozen_string_literal: true

require 'dry/monads'

module Report
  class Build
    include Dry::Monads[:result]

    def self.call(input)
      commands = input.upcase.split("\n")

      commands.each do |command|
        if command.start_with?('PLACE')
          @x_position, @y_position, @direction, @error = GenerateCoordinates.call(command)

        elsif command == 'MOVE'
          @x_position, @y_position = Move.call(@x_position, @y_position, @direction)

        elsif %w[RIGHT LEFT].include?(command)
          @direction = Rotate.call(command, @direction)

        elsif command == 'REPORT'
          return @error&.presence || "#{@x_position},#{@y_position},#{@direction}"
        end
      end
    end
  end
end
