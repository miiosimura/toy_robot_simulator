# frozen_string_literal: true

module Report
  class Build
    def self.call(input)
      commands = input.upcase.split("\n")

      commands.each do |command|
        if command.start_with?('PLACE')
          @x_position, @y_position, @direction, @error = GenerateCoordinates.call(command)
        elsif command == 'MOVE' && place_valid?
          @x_position, @y_position = Move.call(@x_position, @y_position, @direction)
        elsif %w[RIGHT LEFT].include?(command) && place_valid?
          @direction = Rotate.call(command, @direction)
        elsif command == 'REPORT'
          return @error&.presence || "#{@x_position},#{@y_position},#{@direction}"
        end
      end
    end

    def self.place_valid?
      @error.nil?
    end
  end
end
