require 'colorize'
require 'dry/monads'
require_relative '../services/report/validate_place_command'
require_relative '../services/report/generate_coordinates'
require_relative '../services/report/build'
require_relative '../services/report/move'
require_relative '../services/report/rotate'

puts '====================================================='.blue
puts '================ Toy Robot Simulator ================'.blue
puts '====================================================='.blue
puts ''

puts 'Simulate a toy robot moving on a square tabletop, of dimensions 5x5.'
puts ''

puts 'Example of valid commands that you could enter:'.blue
puts 'PLACE 2,3,WEST'.blue
puts 'MOVE'.blue
puts 'LEFT'.blue
puts 'RIGHT'.blue
puts 'REPORT'.blue
puts ''

puts 'The program is finished when REPORT command is executed'

continue = 'Y'

while %w[YES Y].include?(continue.upcase)
  commands = ''

  loop do
    print '* Please enter your command [MOVE, LEFT, RIGHT, REPORT]: '.green
    movement = gets.chomp

    if movement.upcase.start_with?('PLACE')
      valid_place = Report::ValidatePlaceCommand.new(movement).call

      if valid_place.success?
        commands.concat("\n#{movement}")
      else
        puts valid_place&.failure.red
        puts ''
      end
    else
      commands.concat("\n#{movement}")
    end

    break if movement.upcase == 'REPORT'
  end

  puts "\nYour current position is: #{Report::Build.call(commands)}".yellow
  print "\nDo you want to continue? [Y/N] "
  continue = gets.chomp
  puts ''
end
