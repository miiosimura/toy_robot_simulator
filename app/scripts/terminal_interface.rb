require 'colorize'
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

continue = 'Y'

while %w[YES Y].include?(continue.upcase)
  commands = ''

  loop do
    print '* Please place your robot on the table: '.green
    first_place = gets.chomp
    _, _, _, error = Report::GenerateCoordinates.call(first_place)

    commands = first_place

    break if error.nil?

    puts error.red
    puts ''
  end

  loop do
    print '* Please enter your next command [MOVE, LEFT, RIGHT, REPORT]: '.green
    movement = gets.chomp

    commands.concat("\n#{movement}")

    break if movement.upcase == 'REPORT'
  end

  puts "\nYour current position is: #{Report::Build.call(commands)}".yellow
  print "\nDo you want to continue? [Y/N] "
  continue = gets.chomp
  puts ''
end
