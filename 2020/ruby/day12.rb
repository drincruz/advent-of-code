# 2020: Day12
# Part 1
# Given an array of instructions, we want to navigate a ship along an X,Y plane.
# Once we have the final destination, we want to calculate the Manhattan
# Distance.
require_relative './utils'

# Day12
class Day12
  include Utils

  def data
    read_file('day12.txt')
  end

  def parse_line(line)
    # Line format: #{action}#{value}
    # Example line format: R90
    [line[0], line[1..-1].to_i]
  end

  def north_south(current, value)
    [current[0], current[1] + value]
  end

  def east_west(current, value)
    [current[0] + value, current[1]]
  end

  def directions
    %i[north east south west]
  end

  def left(value, current_direction = :east)
    cur_index = directions.find_index(current_direction)
    directions[(cur_index - value / 90) % 4]
  end

  def right(value, current_direction = :east)
    cur_index = directions.find_index(current_direction)
    directions[(cur_index + value / 90) % 4]
  end

  def forward(current, direction, value)
    if direction == :north
      current = north_south(current, value)
    elsif direction == :south
      current = north_south(current, -1 * value)
    elsif direction == :east
      current = east_west(current, value)
    elsif direction == :west
      current = east_west(current, -1 * value)
    end

    current
  end

  def main
    instructions = data.map { |line| parse_line(line) }
    current_direction = :east
    current_location = [0, 0]

    instructions.each do |action, value|
      if action == 'F'
        current_location = forward(current_location, current_direction, value)
      elsif action == 'N'
        current_location = north_south(current_location, value)
      elsif action == 'S'
        current_location = north_south(current_location, -1 * value)
      elsif action == 'E'
        current_location = east_west(current_location, value)
      elsif action == 'W'
        current_location = east_west(current_location, -1 * value)
      elsif action == 'L'
        current_direction = left(value, current_direction)
      elsif action == 'R'
        current_direction = right(value, current_direction)
      end
    end

    puts "#{current_location} #{current_direction}"
    puts current_location[0].abs + current_location[1].abs
  end
end

Day12.new.main
